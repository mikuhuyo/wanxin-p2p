SELECT
	ID AS id,
	CONSUMER_ID AS consumerId,
	USER_NO AS userNo,
	PROJECT_NO AS projectNo,
	NAME AS name,
	DESCRIPTION AS description,
	TYPE AS type,
	PERIOD AS period,
	ANNUAL_RATE AS annualRate,
	BORROWER_ANNUAL_RATE AS borrowerAnnualRate,
	COMMISSION_ANNUAL_RATE AS commissionAnnualRate,
	REPAYMENT_WAY AS repaymentWay,
	AMOUNT AS amount,
	PROJECT_STATUS AS projectStatus,
	CREATE_DATE AS createDate,
	MODIFY_DATE AS modifyDate,
	STATUS AS status,
	IS_ASSIGNMENT AS isAssignment
FROM
	project
WHERE
	MODIFY_DATE >= :sql_last_value
