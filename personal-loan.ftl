<#include "../../macros.ftl"/>

<#--Override the default macros for the website-->
<#include "../macros.ftl"/>

<@s.hidden key="form.details.baseEligibilityId" value="%{baseEligibility.id}"/>
<@s.hidden name="form.details.applicant.employment.type" id="employmentType" value="SALARIED" theme="simple"/>

I live in
<@citySentenceForm/>
&amp; work in
<@companySentenceForm/>.<br/>
<div class="salary-drive-personal">
    I make Rs.
    <@salarySentenceForm/>
    per month. I'd<br/>

</div>
<div class="salary-drive-personal1">
    like a personal loan for Rs. <@intendedLoanSentenceForm "250000" "250,000" "personal-loan"/>.
</div>

