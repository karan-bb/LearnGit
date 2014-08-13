<#include "../../macros.ftl"/>

<#--Override the default macros for the website-->
<#include "../macros.ftl"/>

<@s.hidden key="form.details.baseEligibilityId" value="%{baseEligibility.id}"/>
<@s.hidden key="form.details.applicant.employment.type" value="%{baseEligibility.details.applicant.employment.type}"/>
<@s.hidden key="form.details.property.propertyConstructionType" value="%{baseEligibility.details.property.propertyConstructionType}"/>
<@s.hidden key="form.details.applicant.citizenshipStatus" value="%{baseEligibility.details.applicant.citizenshipStatus}"/>

I live in
<@citySentenceForm/>
& work in
<@companySentenceForm/>
.<br/>
<div class="salary-drive-home">
    I make Rs.
<@salarySentenceForm/>
    per month.  <br/>
    I am  <@loanDecideSentenceForm/> <br/> property worth Rs. <@intendedLoanSentenceForm "2500000" "25,00,000" "home-loan"/>.
</div>