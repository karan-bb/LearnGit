$(function () {
    function initializeNewsletterForm() {
        $('#newsletter_signup_form').ajaxForm(
            {
                url: '/newsletter_signup.html',
                type: 'post',
                dataType: "jsonp",
                jsonp: "jsonp_callback",
                beforeSubmit: function () {
                    if ($('#captcha-holder').is(':visible')) {
                        return true;
                    }
                    $("#captcha-holder").removeClass("hide");
                    $('.footer-subscribe').addClass("subscribeextend");
                    return false;
                },
                complete: function (response) {
                    $('.footer-subscribe').removeClass("subscribeextend");
                    $("#captcha-holder").addClass("hide");
                },
                success: function(response){
                    $(".form-result").text(response.stringResult);
                }
            });
        $('#newsletter_signup_form').validate();
    }
    // autoomplete trigger
    initTypeAhead($("#company-dropdown-input"), "companies", "/autoComplete.html?ajax=true&type=COMPANY&productTypeId="+$("#productTypeId").val(),5);
    initTypeAhead($("#city-dropdown-input"), "cities", "/autoComplete.html?ajax=true&type=CITY&productTypeId="+$("#productTypeId").val());
    initTypeAhead($("#car-dropdown-input"), "car", "/autoComplete.html?ajax=true&type=CAR&productTypeId="+$("#productTypeId").val());
    enableDropdownSelectFields();
    bindingForSelectingAutoComplete();
    initializeRecommender({field: $("#company-dropdown-input"),
        reco: $("select[name='form.applicantPlaceHolder.companyName.recommend']"),
        getDataFromDifferentField: true,
        dataFromField: $("input[name='form.applicantPlaceHolder.companyName']")}
        ,"COMPANY","credit-card");
    // Bindings for different fields
    populateCity();
    setCityFieldBindings();
    setCompanyFieldBindings();
    populateCar();
    setCarFieldBindings();
    setSalaryFieldBindings();
    setIntendedLoanFieldBindings();
    minIntendedLoanAmountCheck();
    setDecidedFieldBindings();
    formatSalary();
    // This is used for form validation
    $("#eForm").submit(function () {
        if (!$("#eForm").valid()) {
            window.scrollTo(0, 0);
            return false;
        }
    });

    initializeNewsletterForm();
    initializeRating();
    initializePaginationForReviewLinks();
    initializeVoting();
    lazyLoadCustomerProfilePic();

    SocialLogin.init();
});


//top menu script
$(".banner a[href^='#']").on('click', function(e) {
    // prevent default anchor click behavior
    e.preventDefault();
    var local_hash = this.hash;
    // animate
    $('html, body').animate({
        scrollTop: $(local_hash).offset().top
    }, 0, function(){
        // when done, add hash to url
        // (default click behaviour)
        window.location.hash = local_hash;
    });
});
$(document).ready(function(){
    /*$('.subscribe .form-group').hide();*/
    $('.subscribe-btn').click(function(){
        $('.footer-subscribe').addClass('subscribeextend');
    });
});

//chrome webfont fix
$(document).ready(function() {
   if($.browser.chrome)
       $("head").append('<style>/* Web Fonts*/ @font-face {    font-family: "webfont"; src: url("webfont.eot");    font-weight: normal;    font-style: normal; }}</style>');
});

// Preventing the dropdown to hide when we click on element with class keep-open
$('.dropdown-menu').find('.keep-open').click(function (e) {
    e.stopPropagation();
});

//function persistAutocompleteDropdown(){
//    $('body').find('.tt-dropdown-menu').click(function (e) {
//        e.stopPropagation();
//    });
//}

function enableDropdownSelectFields(){
    // Enable select fields of bootstrap
    $('.selectpicker').selectpicker({style: 'btn-info'});
}

function populateCity(){
    var city = $('#eForm_form_applicantPlaceHolder_residenceCity_value').val();
    if (city == "OTHER") {
    $("#city-other-input").removeClass("dontshow");
    $(".cityFieldDropdown").addClass("dontshow");
    }
}

function setCityFieldBindings(){
    var setCityForSentenceForm = function(city){
        $("#eForm_form_applicantPlaceHolder_residenceCity_value").val(city);
    };
    var setFallBackCityForSentenceForm = function(city){
        if (city == ""){
           city = "Bangalore";  // TODO get from hidden field, which gets from contants
        }
        $("#eForm_form_applicantPlaceHolder_residenceCity_fallback").val(city);
    };
    // Typing value in dropdown menu input field
     $('#city-dropdown-input').keyup(function(){
         var city = $("#city-dropdown-input").val();
         setFallBackCityForSentenceForm(city);
     });

    // selecting value from auto-complete drop-down
    $('#city-dropdown-input').bind('typeahead:selected', function(obj, datum, name) {
        var city = datum.name;
        setFallBackCityForSentenceForm(city);
    });

        // functionality for other city
    $('#eForm_form_applicantPlaceHolder_residenceCity_value').change(function () {
        if ($("#eForm_form_applicantPlaceHolder_residenceCity_value").val() == "OTHER") {
            $("#city-other-input").removeClass("dontshow");
            $(".cityFieldDropdown").addClass("dontshow");
            setTimeout(function() {
                $("#city-other-input").addClass("open");
                $('#city-dropdown-input').focus();
            }, 300);
        }
    });

    $('#city-other-input').on('show.bs.dropdown', function () {
        setTimeout(function() {
            $('#city-dropdown-input').focus();
        }, 500);
    });
}

function setCompanyFieldBindings(){
    var setCompanyForSentenceForm = function(company){
        if (company == ""){
            company = "Infosys";  // TODO get from hidden field, which gets from contants
        }
        $("#eForm_form_applicantPlaceHolder_companyName").val(company);
    };

    // Typing value in dropdown menu input field
    $('#company-dropdown-input').keyup(function(){
        var company = $("#company-dropdown-input").val();
        setCompanyForSentenceForm(company);
    });

    // selecting value from auto-complete drop-down
    $('#company-dropdown-input').bind('typeahead:selected', function(obj, datum, name) {
        var company = datum.name;
        setCompanyForSentenceForm(company);
    });


    $('#eForm_form_applicantPlaceHolder_companyName_recommend').change(function(){
        var company = $("#eForm_form_applicantPlaceHolder_companyName_recommend").val();
        setCompanyForSentenceForm(company);
        $("#did-you-mean-company").removeClass("orangedrop");
    });
    // Binding for recommendation
    $("#company-dropdown-input").live('showRecommendationDropdown', function(){
        if (!$("#eForm_form_applicantPlaceHolder_companyName").parent().hasClass("open")){
            $("#eForm_form_applicantPlaceHolder_companyName").dropdown("toggle");
        }
    });

    $('#company-dropdown').on('show.bs.dropdown', function () {
        setTimeout(function() {
            $('#company-dropdown-input').focus();
        }, 500);
    });
}

function populateCar(){
    if ($("#carName").val() == "OTHER") {
        $("#car-other-input").removeClass("dontshow");
        $(".carFieldDropdown").addClass("dontshow");
        var otherCarText = $("#staggeredCarName").val();
        $("#eForm_form_carName").val(otherCarText);
    }
}

function setCarFieldBindings(){
    var setCarForSentenceForm = function(car){
        if (car == ""){
            car = "HYUNDAI I10 D-LITE IRDE2";  // TODO get from hidden field, which gets from contants
        }
        $("#eForm_form_carName").val(car);
        $("#staggeredCarName").val(car);
    };

    // Typing value in dropdown menu input field
    $('#car-dropdown-input').keyup(function(){
        var car = $("#car-dropdown-input").val();
        setCarForSentenceForm(car);
    });

    // selecting value from auto-complete drop-down
    $('#car-dropdown-input').bind('typeahead:selected', function(obj, datum, name) {
        var car = datum.name;
        setCarForSentenceForm(car);
    });

    // functionality for other car
        $('#carName').change(function () {
            if ($("#carName").val() == "OTHER") {
                $("#car-other-input").removeClass("dontshow");
                $(".carFieldDropdown").addClass("dontshow");
                setTimeout(function() {
                    $("#car-other-input").addClass("open");
                    $('#car-dropdown-input').focus();
                }, 300);
            } else {
                var car = $("#carName").val();
                setCarForSentenceForm(car);
            }
        });
    $('#car-other-input').on('show.bs.dropdown', function () {
        setTimeout(function() {
            $('#car-dropdown-input').focus();
        }, 500);
    });

}

function setSalaryFieldBindings(){
    // Salary part - set value in display and input field which goes in backend. This is used for sentence form
    $('#monthly-salary-dropdown-input').keyup(function(){
        var t = getFormattedNumber(this.value.replace(/\D/g, ""));
        this.value = (t == 0 && $(this).is(".number")) ? '' : t;
        var monthlySalary = $("#monthly-salary-dropdown-input").val();
        if (monthlySalary == ""){
            monthlySalary = "30,000";  // TODO get from hidden field, which gets from contants
        }
        $("#eForm_form_details_applicant_income_grossMonthlyIncome").val(monthlySalary);
    });

    $('#salary-dropdown').on('show.bs.dropdown', function () {
        setTimeout(function() {
            $('#monthly-salary-dropdown-input').focus();
        }, 500);
    });
}

function setIntendedLoanFieldBindings(){
    // Salary part - set value in display and input field which goes in backend. This is used for sentence form


    $('#intended-loan-amount-dropdown-input').keyup(function(){
        var t = getFormattedNumber(this.value.replace(/\D/g, ""));
        this.value = (t == 0 && $(this).is(".number")) ? '' : t;
        var intendedLoanAmount = $("#intended-loan-amount-dropdown-input").val();
        if (intendedLoanAmount == "" ){
            intendedLoanAmount = $("#intended_loan_default_value").val();
        }
        $("#eForm_form_details_intended_loan_amount").val(intendedLoanAmount);
    });

    $('#intended-loan-amount-dropdown').on('show.bs.dropdown', function () {
        setTimeout(function() {
            $('#intended-loan-amount-dropdown-input').focus();
        }, 500);
    });
}

function minIntendedLoanAmountCheck(){
    // Salary part - set value in display and input field which goes in backend. This is used for sentence form
    $('#intended-loan-amount-dropdown-input').blur(function(){
    var intendedLoanAmount = $("#eForm_form_details_intended_loan_amount").val();
        intendedLoanAmount = intendedLoanAmount.replace(",","");

    if($("#productNameSpace").val() == "home-loan" && intendedLoanAmount < 1000000){
        $("#eForm_form_details_intended_loan_amount").val("10,00,000");
        $("#intended-loan-amount-dropdown-input").val("10,00,000");
    }
    else if($("#productNameSpace").val() == "personal-loan" && intendedLoanAmount < 10000){
        $("#eForm_form_details_intended_loan_amount").val("10,000");
        $("#intended-loan-amount-dropdown-input").val("10,000");
    }
    });

 }

function setDecidedFieldBindings(){
    var controlCarInput =  function(){
        if ($("#carUndecided-from-display").val() == "true"){
            $("#car-collection-part").hide();
            $("#not-decided-part").show();
        } else {
            $("#car-collection-part").show();
            $("#not-decided-part").hide();
        }
    };
    controlCarInput();
    $("#carUndecided-from-display").change(function(){
        controlCarInput();
    });
}

function formatSalary(){
    var monthlySalary =  $("#eForm_form_details_applicant_income_grossMonthlyIncome").val();
    if (monthlySalary != undefined && (!monthlySalary.NaN) && (monthlySalary != "") && (monthlySalary != "N/A")) {
        $("#eForm_form_details_applicant_income_grossMonthlyIncome").val(getFormattedNumber(monthlySalary));
    }
}

function bindingForSelectingAutoComplete(){
    $('.tt-dropdown-menu').click(function (e) {
        e.stopPropagation();
    });
}

$("document").ready(function() {
    setTimeout(function(){$(".product-landing-btn-block a").addClass("animation-target");},3000);
});

$(window).load(function (){
    setTimeout(function(){$("div.cityFieldDropdown").addClass('open');},500);
});