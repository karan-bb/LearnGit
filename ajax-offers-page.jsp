<%@ include file="/common/taglibs.jsp" %>
<head>

</head>

<body>


<!--Top nav-->

<s:set var="pageName" value="%{'searchPage'}"/>
<s:set var="isBootstrapPage" value="%{true}"/>
<s:if test="%{offersFromPartner}">
<s:url id="return_url" value="%{'/'+productNameSpace+'-partners.html'}" includeParams="none">
    <s:param name="formType" value="%{'long'}"/>
    <s:param name="variantOptions" value="%{searchRecord.eligibility.details.uiParameters.variantOptions}"/>
    <%-- TODO: Revert this later, this is for 13143, variant has to be used later --%>
</s:url>
</s:if>
<s:else>

    <s:url id="return_url" value="%{'/'+productNameSpace+'.html'}" includeParams="none">
        <s:param name="formType" value="%{'long'}"/>
        <s:param name="variantOptions" value="%{searchRecord.eligibility.details.uiParameters.variantOptions}"/>
        <%-- TODO: Revert this later, this is for 13143, variant has to be used later --%>
    </s:url>
</s:else>

<jsp:include page="/topPixelFiring.jsp"/>
<s:hidden id="searchReferenceId" name="searchReferenceId" value="%{searchRecord.eligibility.id}" theme="simple" />
<span id="offers_size" class="dontshow"><s:property value="%{searchRecord.cpResponse.offers.size}"/>&nbsp;<s:property value="%{#productName}"/><s:if test="%{searchRecord.cpResponse.offers.size>1}">s</s:if></span>
<input type="hidden" id="searchId_SmartPixel" value='<s:property value="searchRecord.eligibility.id"/>'/>
<input type="hidden" id="mobileProvided_SmartPixel"
       value='<s:property value="searchRecord.eligibility.details.applicant.currentContactDetail.primaryMobile.contact"/>'/>
<input type="hidden" id="maxSaving" name="maxSaving" value="<s:property value="%{maxSavingsFromOffers}"/>">
<input type="hidden" id="offerCount" name="offerCount" value="<s:property value="%{searchRecord.cpResponse.offers.size}"/>">
<input type="hidden" id="maxElig" name="maxElig" value="<s:property value="%{searchRecord.cpResponse.maxLoanAmount}"/>"/>
<input type="hidden" id="minInterest" name="minInterest" value="<s:property value="%{minInterestFromOffers}"/>"/>
<s:hidden value="%{mobileSite}" id="mobileSite" theme="simple"/>

<input type="hidden" class="forPingdom"/>

</div>
<div class="container">
<div class="row">
    <s:include value="/lead/lead_status.jsp" />
    <s:include value="bootstrap-loan-slider.jsp"  />
    <s:include value="/search/products.jsp" />

<div class="row">
    <div class="col-sm-6 col-lg-6 col-md-6 searchreference pull-left">
        Search Reference # :${searchRecord.eligibility.id}
    </div>
    <div class="col-sm-6 col-lg-6 col-md-6 return-form pull-right">
        <a href="${return_url}">Return to form</a>
    </div>
</div>
</div>
</div>
<jsp:include page="/common/tracking/google_smartpixel_codes.jsp"/>
<jsp:include page="/pixelFiring.jsp"/>
</body>
