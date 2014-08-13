<#--This is a place holder for overriding macros of eForm-->
<#--Assumes that the main macro.ftl is included by caller-->
<#assign combined = action.getCombined()!'false'/>
<#macro retirementAge applicantId>
<@s.hidden key="${getApplicant(applicantId, false) + '.employment.retirementAgeInYears'}" value="60" theme="simple"/>
</#macro>

<#macro submit>
<li class="wwgrp" xmlns="//www.w3.org/1999/html">
    <div class="wwsubmit" id="submit_with_seals">
        <input type="image" value=" " alt="<@s.property value="%{submit_button_alt_text}" />" class="submit-new" id="eForm_0" title="<@s.property value="%{submit_button_alt_text}" />" src="${cdnDomain}/images/elig-button.png" />
    </div>
</li>
<#if combined>
    <@loadingBar isLiTagBound=true/>
</#if>
</#macro>

<#macro disclaimer>
    <#assign id = getId('form.disclaimer')/>
<li id="${'wwgrp_'+id}" class="wwgrp disclaimer">
    <div id="${'wwctrl_'+id}" class="wwctrl">
    <@s.checkbox key="form.formDisclaimer" theme="simple" value="true"/>
        <label class="sms-disclaimer"> ${action.getText('form.disclaimer.mp.MReq','')}</label>
    </div>
</li>
</#macro>


<#macro haveAxisCreditCard applicantId>
<@s.radio key="${getApplicant(applicantId, true) + '.existingCCBankId[0]'}" parentCss="radio" list="axisCreditCard"/>
</#macro>

<#macro locationOfLand>
<@s.radio key="${'form.details.property.locationOfLand'}" parentCss="radio" list="enum_LocationOfLand"/>
</#macro>

<#macro typeOfTransaction>
<@s.radio key="${'form.details.property.typeOfTransaction'}" parentCss="radio" list="enum_TypeOfTransaction"/>
</#macro>

<#macro seller>
<@s.radio key="${'form.details.property.seller'}" parentCss="radio" list="enum_Seller"/>
</#macro>

<#macro applicantCcBanks applicantId>
<@s.select headerKey="" headerValue="Select" key="${getApplicant(applicantId, true)+'.havingCCBankId[0]'}"
id="${'applicantCcBanks_'+applicantId}" cssClass="float_left" list="emptyList" helpMsg="${action.getText('ccBanks.helpMsg')}" multiple="true">
<@s.optgroup list="salaryAccountBankList" label="----------"/>
<@s.optgroup list="salaryAccountSecondaryBankList" label="----------"/>
<@s.optgroup list="otherBankList" label="----------"/>
<@s.optgroup list="noBankList" label="----------"/>
</@s.select>
</#macro>


<#macro axisAccount_CustomerNumber applicantId >
<@s.hidden key="${getApplicant(applicantId, false) + '.existingBankAccounts[0].bank.id'}" value="12"/>
    <#assign accountKey = "${getApplicant(applicantId, false) + '.existingBankAccounts[0].accountNumber'}"/>
    <#assign customerKey = "${getApplicant(applicantId, false) + '.existingBankAccounts[0].customerId'}"/>
<li class="wwgrp account-box dontshow">
    <div class="form_header">${action.getText('form.accountBox.formHeader','')}</div>
    <div class="width100 block account">
        <div class="hldr axis-ac-info-left">
            <label>${action.getText(accountKey)}</label>
        <@s.textfield key="${accountKey}" maxLength="15" cssClass="customVal" theme="simple"/>
            <div class="custom_error wwerror"></div>
        </div>
        <div class="hldr axis-ac-info-right">
            &nbsp;OR&nbsp;
            <label>${action.getText(customerKey)}</label>
        <@s.textfield key="${customerKey}" maxLength="9" cssClass="customVal" theme="simple"/>
            <div class="custom_error wwerror"></div>
        </div>
    </div>
</li>
</#macro>

<#macro salaryAccount applicantId>
<li class="wwgrp radio odd" id="wwgrp_salaryAccount_radio_0">
    <div class="wwlbl" id="wwlbl_salaryAccount_radio_0">
        <label class="desc"> Where is your salary account?
        </label></div>
    <div class="wwctrl" id="wwctrl_salaryAccount_radio_0">
    <@s.iterator var="bankList" value="%{#shortSalaryAccountBankList}" status="index">
        <input type="radio" value="<@s.property value='%{#bankList.key}'/>"
               id="salaryAccount_radio_0<@s.property value='%{#bankList.key}'/>"
               name="form.details.applicant.existingBankAccounts[0].bank.id" class="salaryAccountBankRadio"><label
            for="salaryAccount_radio_0<@s.property value='%{#bankList.key}'/>"><@s.property value="%{#bankList.value}"/></label>
    </@s.iterator>
        <input type="radio" value="<@s.property value='%{form.details.applicant.existingBankAccounts[0].bank.id}'/>"
               id="salaryAccount_radio_00"
               name="form.details.applicant.existingBankAccounts[0].bank.id">
    <@s.select headerKey="" headerValue="Select another bank" key="salaryBankDropdown" id="${'other_salaryAccount_radio_'+applicantId}" list="emptyList" theme="simple">
    <@s.optgroup list="salaryAccountBankList" label="----------"/>
    <@s.optgroup list="salaryAccountSecondaryBankList" label="----------"/>
    <@s.optgroup list="otherBankList" label="----------"/>
    <@s.optgroup list="CheckOrCashList" label="----------"/>
    </@s.select>
    </div>
</li>
</#macro>

<#macro axisAccount_CustomerNumber applicantId >
    <@s.hidden key="${getApplicant(applicantId, true) + '.axisAccountDetails.bankId'}" value="12"/>
    <#assign accountKey = "${getApplicant(applicantId, true) + '.axisAccountDetails.accountNumber'}"/>
    <#assign loanAccountKey = "${getApplicant(applicantId, true) + '.axisAccountDetails.loanAccountNumber'}"/>
    <#assign customerKey = "${getApplicant(applicantId, true) + '.axisAccountDetails.customerId'}"/>
<li class="wwgrp account-box dontshow" id="accountBox">
    <div class="form_header">${action.getText('form.axisAccountHeader','')}</div>
    <div class="width100 block account">
        <div class="hldr axis-ac-info-left">
            <label>${action.getText(accountKey)}</label>
            <@s.textfield key="${accountKey}" maxLength="15" cssClass="customVal" theme="simple"/>
            <div class="custom_error wwerror"></div>
        </div>
        <@s.if test="%{productNameSpace == 'credit-card'}">
            <div class="hldr axis-ac-info-center" id="axisLoanAccountNumber">
                &nbsp;OR&nbsp;
                <label>${action.getText(loanAccountKey)}</label>
                <@s.textfield key="${loanAccountKey}" maxLength="15" cssClass="customVal" theme="simple"/>
                <div class="custom_error wwerror"></div>
            </div>
        </@s.if>
        <div class="hldr axis-ac-info-right">
            &nbsp;OR&nbsp;
            <label>${action.getText(customerKey)}</label>
            <@s.textfield key="${customerKey}" maxLength="9" cssClass="customVal" theme="simple"/>
            <div class="custom_error wwerror"></div>
        </div>
    </div>
</li>
</#macro>

<#macro salaryAccountMobile applicantId>
<li class="wwgrp select odd" id="wwgrp_salaryAccount">
    <div class="wwlbl" id="wwlbl_salaryAccount">
        <label class="desc"> Where is your salary account?
        </label></div>
    <div class="wwctrl" id="wwctrl_salaryAccount">
    <@s.select headerKey="" headerValue="Select bank" name="form.details.applicant.existingBankAccounts[0].bank.id" list="emptyList" theme="simple">
    <@s.optgroup list="salaryAccountBankList" label="----------"/>
    <@s.optgroup list="salaryAccountSecondaryBankList" label="----------"/>
    <@s.optgroup list="otherBankList" label="----------"/>
    <@s.optgroup list="CheckOrCashList" label="----------"/>
    </@s.select>
    </div>
</li>
</#macro>

<#macro salaryAccountStaggered applicantId>
<li class="wwgrp radio odd dontshow" id="wwgrp_salaryAccount_radio_0">
    <div class="wwctrl" id="wwctrl_salaryAccount_radio_0">
        <div class="bank-lists">
        <@s.if test="%{productNameSpace != 'credit-card'}">
            <#assign list="%{#shortSalaryAccountBankList}"/>
        </@s.if>
        <@s.else>
            <#assign list="%{#CreditCardSalaryAccount}"/>
        </@s.else>
        <@s.iterator var="bankList" value="${list}" status="index">
            <div class="bank-ac">
                <span class='bank-logo img_bankicon_<@s.property value='%{#bankList.key}'/>'></span>
                    <span class="bank-name">
                        <label for="salaryAccount_radio_0<@s.property value='%{#bankList.key}'/>"><@s.property value="%{#bankList.value}"/></label>
                    </span>
                <input type="radio" class="bank-radio" value="<@s.property value='%{#bankList.key}'/>"
                       id="salaryAccount_radio_0<@s.property value='%{#bankList.key}'/>"
                       name="form.details.applicant.existingBankAccounts[0].bank.id">
            </div>
        </@s.iterator>

            <div class="bank-ac bank-others ">
                <span class="bank-pics-4 newstaggered-bg"></span>
               <span class="bank-name">
                   <label for="salaryAccount_radio_0999">OTHER BANK</label>
               </span>
                <input type="radio" value="<@s.property value='999'/>" id="salaryAccount_radio_0999"
                       name="form.details.applicant.existingBankAccounts[0].bank.id" class="bank-radio"/>
            </div>

            <div class="bank-ac bank-last">
                <span class="newstaggered-bg bank-pics-5"></span>
               <span class="bank-name">
                   <label for="salaryAccount_radio_0-1">I receive my salary<br> in cash/cheque</label>
               </span>
                <input type="radio" value="<@s.property value='-1'/>" id="salaryAccount_radio_0-1"
                       name="form.details.applicant.existingBankAccounts[0].bank.id" class="bank-radio"/>
            </div>

        </div>
    </div>

</li>
</#macro>

<#macro monthlyTakeHomeSalary applicantId>
<@incomeField_ getApplicant(applicantId, false) + '.income.monthlyTakeHomeSalary'/>
</#macro>

<#macro savingsAccountStaggered applicantId>
<li class="wwgrp checkbox odd dontshow" id="wwgrp_eForm_form_applicantPlaceHolder_existingSavingAccountId">
    <div class="wwctrl" id="wwctrl_eForm_form_applicantPlaceHolder_existingSavingAccountId">
        <div class="bank-lists self-bank-ac">

            <@s.iterator var="bankList" value="%{#CreditCardSavingAccount}" status="index">
                <div class="sav-bank-ac">
                    <span class='bank-logo img_bankicon_<@s.property value='%{#bankList.key}'/>'></span>
                    <span class="bank-name">
                        <label for="form.applicantPlaceHolder.existingSavingAccountId-<@s.property value='%{#index.count}'/>"><@s.property value="%{#bankList.value}"/></label>
                    </span>
                    <input type="checkbox" class="salaryAccountBankCheckbox" value="<@s.property value='%{#bankList.key}'/>"
                           id="form.applicantPlaceHolder.existingSavingAccountId-<@s.property value='%{#index.count}'/>"
                           name="form.applicantPlaceHolder.existingSavingAccountId">
                </div>
            </@s.iterator>

        </div>
    </div>

</li>
</#macro>

<#macro existingCCStaggered applicantId>
<li class="wwgrp checkbox odd dontshow" id="wwgrp_eForm_form_applicantPlaceHolder_existingCCBankId">
    <div class="wwctrl" id="wwctrl_eForm_form_applicantPlaceHolder_existingCCBankId">
        <div class="bank-lists self-bank-ac">

            <@s.iterator var="bankList" value="%{#CreditCardBankList}" status="index">
                <div class="existing-cc">
                    <span class='bank-logo img_bankicon_<@s.property value='%{#bankList.key}'/>'></span>
                    <span class="bank-name">
                        <label for="form.applicantPlaceHolder.existingCCBankId-<@s.property value='%{#index.count}'/>"><@s.property value="%{#bankList.value}"/></label>
                    </span>
                    <input type="checkbox" class="creditCardBankCheckbox" value="<@s.property value='%{#bankList.key}'/>"
                           id="form.applicantPlaceHolder.existingCCBankId-<@s.property value='%{#index.count}'/>"
                           name="form.applicantPlaceHolder.existingCCBankId">
                </div>
            </@s.iterator>

        </div>
    </div>

</li>
</#macro>

<#macro monthlyTakeHomeSalary_el applicantId labelVal="">
    <@s.textfield key="${getApplicant(applicantId, false) + '.income.monthlyTakeHomeSalary'}" label="${action.getText(getApplicant(applicantId, false) + '.income.monthlyTakeHomeSalary' + labelVal)}" cssClass="number" maxLength="12"/>
</#macro>

<#macro staggeredGrossMonthlyIncome applicantId product="">
<li id="wwgrp_eForm_form_details_applicant_income_grossMonthlyIncome" class="wwgrp dontshow">
    <div id="wwlbl_eForm_form_details_applicant_income_grossMonthlyIncome" class="wwlbl">
        <label class="desc" for="eForm_form_details_applicant_income_grossMonthlyIncome">Every Month I get
            paid</label>
    </div>
    <div id="wwctrl_eForm_applicant_income_grossMonthlyIncome" class="wwctrl">
        <div class="labelover">
            <label class="over-apply " for="eForm_form_details_applicant_income_grossMonthlyIncome"
                   style="text-indent:-10000px;"></label>
                <span class="salary-amount newstaggered-bg"><input
                        id="eForm_form_details_applicant_income_grossMonthlyIncome" class="mobilefield number"
                        type="text" maxlength="12"
                        name="form.details.applicant.income.grossMonthlyIncome" value="<@s.property value="%{form.details.applicant.income.grossMonthlyIncome}"/>"></span>
        </div>
            <span class="company-blk"> as a <span class="takehome"> gross monthly </span> salary  by <span class="companyname"></span></span>


        <div class="tooltip-1 newstaggered-bg">This is your gross monthly salary
            as per your monthly payslip prior to deductions.
        </div>

    </div>

</li>


</#macro>


<#macro staggeredMonthlyTakeHomeSalary applicantId >
<li id="wwgrp_eForm_form_details_applicant_income_monthlyTakeHomeSalary" class="wwgrp dontshow">
    <div id="wwlbl_eForm_form_details_applicant_income_monthlyTakeHomeSalary" class="wwlbl">
        <label class="desc" for="eForm_form_details_applicant_income_monthlyTakeHomeSalary">Every Month I get
            paid</label>
    </div>
    <div id="wwctrl_eForm_applicant_income_monthlyTakeHomeSalary" class="wwctrl">
        <div class="labelover">
            <label class="over-apply " for="eForm_form_details_applicant_income_monthlyTakeHomeSalary"
                   style="text-indent:-10000px;"></label>
                <span class="salary-amount newstaggered-bg"><input
                        id="eForm_form_details_applicant_income_monthlyTakeHomeSalary" class="mobilefield number"
                        type="text" maxlength="12"
                        name="form.details.applicant.income.monthlyTakeHomeSalary"></span>
        </div>
            <span class="company-blk"> as a <span class="takehome"> take home</span> salary by
                <span class="companyname"></span>
            </span>

        <div class="tooltip-1 newstaggered-bg">This is your net monthly salary as credited to your bank account. Do not include
            deductions.
        </div>
    </div>

</li>


</#macro>

<#macro carDetails>
<li class="wwgrp radio odd" id="wwgrp_carName">
    <div class="wwlbl" id="wwlbl_carName">
        <label class="desc">Make/model (optional)
        </label></div>
    <div class="wwctrl" id="wwctrl_carName">
    <@s.iterator var="carList" value="%{getTopCars()}" status="index">
        <input type="radio" value="<@s.property value='%{#carList.description}'/>"
               id="carName<@s.property value='%{#carList.id}'/>"
               name="form.carName" class="carRadioButton optional"><label
            for="carName<@s.property value='%{#carList.id}'/>"><@s.property value="%{#carList.name}"/></label>
    </@s.iterator>
        <span class="car-radio">
        <input type="radio" value="<@s.property value='%{form.carName}'/>" id="carName0"
               name="form.carName" class="optional">
        <span class="labelover">
            <label for="eForm_form_carName" class="over-apply">Type other car name</label>
        <@s.textfield key="carNameTextBox"  id="eForm_form_carName" cssClass="elarge carComplete optional" maxLength="100" theme="simple"/>
        </span>
        </span>
    </div>
</li>
<@s.select key="${'form.carName.recommend'}" cssClass="car elarge recommend optional" parentCss="dontshow" disabled="true" list="%{#emptyList}"/>
<@s.hidden name="${'carNameMatched'}" id="carNameMatched" value="%{form.details.carToPurchase != null}"/>
<@s.label key="${'form.details.carToPurchase.nationalPrice'}" id="carPrice" value="%{form.details.carToPurchase.nationalPrice}" parentCss="dontshow"/>
</#macro>


<#macro staggeredcarDetails>

<li class="wwgrp radio odd" id="wwgrp_carName">
    <div class="wwctrl" id="wwctrl_carName">
        <div class="carstrip">
            <div id=car-group>
            <@s.iterator var="carList" value="%{getTopCars()}" status="index">
                <div class="car-name">
                    <span class="carName<@s.property value='%{#index.index}'/> cars"></span>
                        <span class="car-title">
                            <label for="carName<@s.property value='%{#carList.id}'/>"><@s.property value="%{#carList.name}"/></label>
                        </span>
                    <input type="radio" class="car-radio optional" value="<@s.property value='%{#carList.description}'/>"
                           id="carName<@s.property value='%{#index.index}'/>" name="form.carName">
                </div>
            </@s.iterator>

                <div class="car-name car-others " id="otherCarsRadio">
                    <span class="carName cars"></span>
                    <span class="car-title"><labelfor="carName">OTHER</label></span>
                    <input type="radio" value="<@s.property value="other"/>" id="carNameOtherRadio" name="form.carName" class="optional">
                </div>

                <div class="car-name car-others dontshow wwctrl" id="otherCarsText">
                    <span class="car-form-title1"><labelfor="carName">Make/Model</label></span>
                    <div class="car-form-title2">Type other car name</div>
                    <div class="labelover">
                        <label class="over-apply " for="eForm_form_carName" style="text-indent: 0;"></label>
                        <input type="text" id="eForm_form_carName" name="carNameTextBox"
                               class="carComplete elarge ac_input optional"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="model-later " id="decide-later">
       <span class="link"> I will decide the car model later </span>
    </div>

</li>
<#--  <@s.textfield key="${'form.carName'}" cssClass="elarge carComplete" maxLength="100" default="" value=""/>   -->

</#macro>

<#macro staggeredHeader currentStep totalSteps pageHeader >


<div class="staggered-steps newstaggered-bg"><span>Step ${currentStep} of ${totalSteps}:</span> ${pageHeader}</div>
</#macro>

<#macro staggeredFooter customerMessage step>
<div class="staggered-foot">
    <div class="float_left">
        <strong>Why is this important?</strong>
        <span class="tip-notes-info">${customerMessage}</span>
    </div>
    <div class="foot-button">
        <span class="back-button newstaggered-bg dontshow" id="go-back"></span>
        <button type="submit" value="" class="button${step} next-button newstaggered-bg" id="go-next"></button>

    </div>
    <div class="clear"></div>
</div>
</#macro>


<#macro spanHeader header>
    <span class="step${stepCount} <#if stepCount != 1>dontshow</#if>">
        <@staggeredHeader stepCount totalSteps header/>
    </span>
    <#assign stepCount = stepCount + 1/>
</#macro>

<#macro carBooking >
    <@s.if test="%{carBookingEnabled || (#showEligibility && form.details.applicant.carBookingStatus != null && form.details.applicant.carBookingStatus!='')}">
    <li class="wwgrp radio odd" id="wwgrp_carBooking_radio_0">
        <div class="wwlbl" id="wwlbl_carBooking_radio_0">
            <label class="desc"> Have you booked your car yet?
            </label></div>
        <div class="wwctrl" id="wwctrl_carBooking_radio_0">
            <@s.iterator var="carBookingList" value="%{#carBookingList}" status="index">
                <input type="radio" value="<@s.property value='%{#carBookingList.key}'/>"
                       id="carBooking_radio_0<@s.property value='%{#index.index}'/>"
                       name="form.details.applicant.carBookingStatus" class="carBookingRadio"><label
                    for="carBooking_radio_0<@s.property value='%{#index.index}'/>"><@s.property value="%{#carBookingList.value}"/></label>
            </@s.iterator>
            <input type="radio" value="<@s.property value='%{form.details.applicant.carBookingStatus}'/>"
                   id="carBooking_radio_99"
                   name="form.details.applicant.carBookingStatus" class="dontshow">
        </div>
    </li>
    </@s.if>
</#macro>

<#macro bookingSoon>
    <#assign labelVal = 'dontshow'/>
    <@s.if test="%{form.details.applicant.bookingSoonStatus!=null && form.details.applicant.bookingSoonStatus!=''}">
        <#assign labelVal = ''/>
    </@s.if>
    <@s.if test="%{bookingSoonEnabled || (#showEligibility && form.details.applicant.bookingSoonStatus!=null && form.details.applicant.bookingSoonStatus!='')}">
        <@s.select key="${'form.details.applicant.bookingSoonStatus'}" list="list_bookingSoonList" label ="When do you plan to book your car?" headerKey="" headerValue="Select" cssClass="float_left"  parentCss="${labelVal}" />
    </@s.if>
</#macro>

<#macro cityAutoFillBoxSentenceForm>
<span id="city-other-input" class="dropdown dontshow">
<input  id="eForm_form_applicantPlaceHolder_residenceCity_fallback" name="form.applicantPlaceHolder.residenceCity.fallback" data-toggle="dropdown" class="cl-el-state truncatedText12"
        value="<@s.property value='%{form.applicantPlaceHolder.residenceCity != null &&
         form.applicantPlaceHolder.residenceCity.fallback != null ? form.applicantPlaceHolder.residenceCity.fallback :  "Chennai" }'/>"
        maxlength="30"
        allowedCharSet="a-zA-Z"
        readonly="true"/>
<span class="dropdown-arrow"></span>
<ul class="dropdown-menu cl-mnth-earn" role="menu" aria-labelledby="dLabel">
    <li>
        <div class="input-group">
            <input type="text" id="city-dropdown-input" class="form-control monthly-earning keep-open" placeholder="Chennai">
<span class="input-group-btn">
<button id="city-btn" class="btn btn-default monthly-earning-btn" type="button">
    Ok
</button>
</span>
        </div>
    </li>
</ul>
</span>
</#macro>

<#macro citySentenceForm>

<select id="eForm_form_applicantPlaceHolder_residenceCity_value" name="form.applicantPlaceHolder.residenceCity.value" class="mbn cl-el-state selectpicker cityFieldDropdown"  style="visibility:hidden;width:153px;">
    <@s.iterator var="cityList" value="%{#topCityList}" status="index">
        <option value="<@s.property value="%{#cityList.key}"/>"
            <@s.property value='%{form.applicantPlaceHolder.residenceCity.value != null && form.applicantPlaceHolder.residenceCity.value == #cityList.key ? "selected" : ""}'/>>
        <@s.property value="%{#cityList.value}"/>
        </option>
    </@s.iterator>
    <option value="OTHER"  <@s.property value='%{form.applicantPlaceHolder.residenceCity.value == "OTHER" ? "selected" : ""}'/>>
    Other City</option>
</select>
    <@cityAutoFillBoxSentenceForm/>
</#macro>

<#macro companySentenceForm>
<span id="company-dropdown" class="dropdown">
                    <input data-toggle="dropdown" class="cl-el-state truncatedText12"
                           id="eForm_form_applicantPlaceHolder_companyName" name="form.applicantPlaceHolder.companyName"
                           value="<@s.property value='%{form.applicantPlaceHolder.companyName != null ? form.applicantPlaceHolder.companyName :  "Infosys" }'/>"
                            readonly="true"/>
                       <span class="dropdown-arrow"></span>
                        <ul class="dropdown-menu cl-mnth-earn" role="menu" aria-labelledby="dLabel">
                            <li>
                                <div class="input-group">
                                    <input type="text"
                                           class="form-control monthly-earning keep-open companyComplete ac_input"
                                           autocomplete="off" id="company-dropdown-input" autocorrect="off"
                                           placeholder="Infosys">
                                    <span class="input-group-btn">
                                        <button id="company-btn" class="btn btn-default monthly-earning-btn"
                                                type="button">Ok
                                        </button>
                                    </span>
                                </div>
                            </li>
                            <li class="dontshow">
                                <div class="orangedrop form-group keep-open" id="did-you-mean-company">
                                    <label>Did you mean this ?</label>
                                    <div class="combobox-container combobox-selected">
                                    </div>
                                    <select name="form.applicantPlaceHolder.companyName.recommend" id="eForm_form_applicantPlaceHolder_companyName_recommend" class="company recommend select-option-required dontvalidate combobox input-large form-control"></select>
                                </div>
                            </li>
                        </ul>
</span>
</#macro>

<#macro salarySentenceForm>
<span id="salary-dropdown" class="dropdown">
    <input data-toggle="dropdown" class="cl-el-state el-input number" id="eForm_form_details_applicant_income_grossMonthlyIncome"
       name="form.details.applicant.income.grossMonthlyIncome"
       value="<@s.property value='%{form.details.applicant.income.grossMonthlyIncome != null ? form.details.applicant.income.grossMonthlyIncome :  "30000" }'/>"
       readonly="true"/>
   <span class="dropdown-arrow"></span>
    <ul class="dropdown-menu cl-mnth-earn" role="menu" aria-labelledby="dLabel">
        <li>
            <div class="input-group">

                <input type="text" id="monthly-salary-dropdown-input"
                       class="form-control monthly-earning keep-open number" placeholder="30,000" maxlength="12"/>
                <span class="input-group-btn">
                    <button id="monthly-earning-btn" class="btn btn-default monthly-earning-btn"
                            type="button">Ok
                    </button>
                </span>
            </div>`
        </li>
    </ul>
</span>
</#macro>

<#macro intendedLoanSentenceForm defaultVal placeHolderVal productNamespace>
<#assign loanAmount="${defaultVal}"/>
<#assign placeHolder="${placeHolderVal}"/>
<@s.if test="%{sessionIntendedLoanAmountMap !=null }">
    <@s.if test="%{sessionIntendedLoanAmountMap.get('${productNamespace}') != null}" >
        <#--<input type="hidden" id="loan_value" value="${sessionIntendedLoanAmountMap.get('${productNamespace}')}" />-->
        <#assign loanAmount="${sessionIntendedLoanAmountMap.get('${productNamespace}')}" />
    </@s.if>
</@s.if>
<span id="intended-loan-amount-dropdown" class="dropdown">
    <input data-toggle="dropdown" class="cl-el-state el-input1 number" id="eForm_form_details_intended_loan_amount"
           name="form.details.intendedLoanAmount"
           value="<@s.property value='%{form.details.intendedLoanAmount != null ? "${loanAmount}" :"${defaultVal}"}'/>"
           readonly="true"/>
    <input type="hidden" id="intended_loan_default_value" value="${defaultVal}">
    <span class="dropdown-arrow"></span>
    <ul class="dropdown-menu cl-mnth-earn" role="menu" aria-labelledby="dLabel">
        <li>
            <div class="input-group">
                <input type="text" id="intended-loan-amount-dropdown-input"
                       class="form-control monthly-earning keep-open number" placeholder= ${placeHolderVal} maxlength="12"/>
                <span class="input-group-btn">
                    <button id="intended-loan-amount-btn" class="btn btn-default monthly-earning-btn" type="button">Ok</button>
                </span>
            </div>
        </li>
    </ul>
</span>
</#macro>

<#macro carSentenceForm>
<@s.hidden name="staggeredCarName" id="staggeredCarName" value="%{form.carName != null ? form.carName :  'MARUTI SUZUKI ALTO STD'}" />
<#--<input type="text" class="dontshow" id="eForm_form_carName" name="form.carName" value="Alto"/>-->
<!-- car-field to carName-->
<select id="carName" name="form.carName" class="mbn cl-el-car selectpicker carFieldDropdown">
    <@s.iterator var="carList" value="%{getTopCars()}" status="index">
        <option value="<@s.property value="%{#carList.description}"/>"
            <@s.property value='%{form.carName != null && form.carName == #carList.description ? "selected" : ""}'/>>
            <@s.property value="%{#carList.name}"/>
        </option>
    </@s.iterator>
    <option value="OTHER" <@s.property value='%{ form.carName != null && !presentInTopCars ? "selected" : ""}'/>>Other</option>
</select>
<!--auto fill box !-->
<span id="car-other-input" class="dropdown dontshow">
<input id="eForm_form_carName" data-toggle="dropdown" class="cl-el-state truncatedText12"
       value="<@s.property value='%{form.carName != null ? form.carName :  "MARUTI SUZUKI ALTO STD" }'/>"
       readonly="true"/>
   <span class="dropdown-arrow"></span>
    <ul class="dropdown-menu cl-mnth-earn" role="menu" aria-labelledby="dLabel">
        <li>
            <div class="input-group">
                <input type="text" id="car-dropdown-input"
                       class="form-control monthly-earning keep-open" placeholder="Maruti Alto">
                <span class="input-group-btn">
                    <button id="car-btn" class="btn btn-default monthly-earning-btn" type="button">
                        Ok
                    </button>
                </span>
            </div>
        </li>
    </ul>
</span>
</#macro>

<#macro carDecideSentenceForm>
<select name="form.details.carUndecided" id="carUndecided-from-display" class="mbn cl-el-decide selectpicker">
    <option value="false" <@s.property value='%{form.details.carUndecided != null && !form.details.carUndecided ? "selected" : ""}'/>>Decided</option>
    <option value="true" <@s.property value='%{form.details.carUndecided != null && form.details.carUndecided ? "selected" : ""}'/>>Not decided</option>
</select>
</#macro>

<#macro loanDecideSentenceForm>
<select name="form.details.loanUndecided" id="loanUndecided-from-display" class="mbn cl-el-decide selectpicker" style="visibility:hidden;width:363px;">
    <option value="false" <@s.property value='%{form.details.loanUndecided != null && !form.details.loanUndecided ? "selected" : ""}'/>>considering buying </option>
    <option value="true" <@s.property value='%{form.details.loanUndecided != null && form.details.loanUndecided ? "selected" : ""}'/>>checking rates for</option>
</select>
</#macro>