CREATE OR REPLACE FORCE VIEW "UNITE"."UOP_CS15_VIEW" ("APARLINE") AS 
  with agr_ho_status as (
select /*+ cursor_sharing_exact */
aglrelvalue."att_value" agr_s_id, aglrelvalue."rel_value" agr_ho_status
from "aglrelvalue"@agr55 aglrelvalue where
aglrelvalue."attribute_id" = 'A4'
AND aglrelvalue."rel_attr_id" = '12')
select/*+ cursor_sharing_exact */ distinct aparline
from (
SELECT DISTINCT 
'1' || -- what is this for CS15? full_record
                --decode(a_transferred, -1, 'U', 'I') || --?
decode("apar_id", null, 'I', 'U') || --cs15? change_status
rpad('01', 25) || --apar_gr_id
Rpad(t2.s_StudentReference,25) || --apar_id
Rpad(' ',25) || --apar_id_ref
Rpad(text_utils.strip_bad(t1.p_Forenames) ||' ' || text_utils.strip_bad(t1.p_Surname),255) || --apar_name
--	        '0' || --apar_once
'R' || -- apar type
Rpad('0',35) || --bank account
rpad(' ',35) || --iban
Rpad(' ',4) || --bonus gr
Rpad(' ',3) || --cash delay
Rpad(' ',13) || --clearing code
rpad('UP', 25) || --client
rpad(' ',1) || --collect_flag
rpad(nvl(s_slcsupportnumber, ' '), 25) || -- comp reg no
Rpad('C',1) || --control
--                rpad('GB', 25) || --country code
Rpad('0',20) || --credit limit
rpad('GBP', 25) || --currency
rpad('0', 1) || --currency set
--                Rpad(' ',255) || --description
Rpad(' ',4) || --disc code
--                Rpad(' ',8) || --expired date
Rpad(t2.s_studentreference,100) || --ext apar ref
--                Rpad('0',2) || --fac short set
Rpad(' ',25) || --factor short
Rpad(' ',35) || --foreign acc
Rpad(' ',25) || --intrule id
Rpad(' ',25) || -- invoice code
Rpad('EN',2) || --language
rpad(t2.s_studentreference, 25) || --main apar id
Rpad(' ',255) || -- message text
RPAD(' ', 3) || -- pay delay
Rpad('CH',2) || --pay method
--                LPAD('0', 2) || --pay method set
--                Rpad(' ',4) || --pay temp id
rpad('0', 35) || --postal acc
Rpad(' ',1) || --priority no
Rpad(substr(nvl(rtrim(text_utils.strip_bad(p_surname)), '.'), 1, 10),10) || --short name
rpad('N', 1) || --status
Rpad(' ',11) || --swift
--		rpad(' ', 25) || --tax code
rpad('0', 1) || --tax set
rpad(' ', 25) || --tax system
--		lpad('0', 2) || --tc set
rpad(' ', 25) || --terms id
rpad('0', 1) || --terms set
rpad(' ', 25) || --vat reg no
--		rpad('DESC', 4) ||
--		rpad('EN', 2) || --language
--		rpad(text_utils.strip_bad(t1.p_Forenames) ||' ' || text_utils.strip_bad(t1.p_Surname), 255) || --description
--	        rpad('ADDR', 4) ||
rpad(nvl(Substr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.'),1,Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,1) - 1), ' '), 40) || -- address1
rpad(nvl(Ltrim(Substr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.'),Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,2 - 1) + Length(Chr(13) ||Chr(10)), (Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,2) - Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,2 - 1) - Length(Chr(13) ||Chr(10))))), ' '), 40) || --address2
rpad(nvl(Ltrim(Substr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.'),Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,3 - 1) + Length(Chr(13) ||Chr(10)), (Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,3) - Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,3 - 1) - Length(Chr(13) ||Chr(10))))), ' '), 40) || --address3
rpad(nvl(Ltrim(Substr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.'),Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,4 - 1) + Length(Chr(13) ||Chr(10)), (Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,4) - Instr(Nvl(text_utils.strip_bad(t3.a_Name) ||'. ' ,'.') ||Chr(13) ||Chr(10),Chr(13) ||Chr(10),1,4 - 1) - Length(Chr(13) ||Chr(10))))), ' '), 40) || --address4
rpad('1', 1) || -- address type
rpad(' ', 25) || -- agr_user_id
rpad(' ', 255) || --e_email_cc
Rpad('GB',25) || -- country code
Rpad(' ',255) || --description
Rpad(' ',50) || --ean
Rpad(' ',40) || --place
Rpad(' ',40) || --province
Rpad(nvl(ltel.t_name,' '),35) || -- telephone 1
Rpad(' ',35) || -- telephone 2
Rpad(' ',35) || --telephone 3
Rpad(' ',35) || --telephone 4
Rpad(' ',35) || --telephone 5
Rpad(' ',35) || --telephone 6
Rpad(' ',35) || --telephone 7
Rpad(replace(replace(nvl(emailaddr.a_name, ' '), chr(10)), chr(13)),255) || --e mail
Rpad( NVL(t3.a_reference, ' '),15) || --zip code
Rpad(' ',255) || --url path
Rpad(' ',35) || -- pos title
rpad(' ',4) || --pay_temp_id
rpad(' ',255) || --reference_1
rpad(' ',25) ||--old_rel_value
Rpad('12',4) || -- rel attr id
RPAD(nvl(t2.s_studentcategory, 'H'), 25) --rel value
		aparline ,
	  agladdr."address" agladdress,
		t3.a_reference postcode,
		t6.s_academicyear academicyear,
		agladdr."e_mail" aglemail,
		agladdr."zip_code" aglzipcode,
		agladdr."telephone_1" telephone1,
    acuhead."comp_reg_no" compregno,
    t2.s_slcsupportnumber slcsupportnumber,
    agr_ho_status.agr_ho_status,
    t2.s_studentcategory unite_ho_status
FROM   Capd_Student t2,
       Capd_Address t3,
       Capd_Address emailaddr,
       Capd_ModuleEnrolMent t4,
       Capd_Person t1,
       Capd_Session t6,
       Capd_Module t5,
       "acuheader"@agr55 acuhead ,
       "agladdress"@agr55 agladdr,
       agr_ho_status agr_ho_status,
       capd_telephone ltel
WHERE  t2.s_Id (+)  = t1.p_Id
       AND (t2.s_StudentLocalAddress = t3.a_Id (+) )
       and (t2.s_studentemailaddress = emailaddr.a_id (+))
       AND (t4.e_Student = t1.p_Id)
       AND (t4.e_Module = t5.m_Id)
       AND t4.e_status in ('P', 'L')
       AND (t5.m_ModuleSession = t6.s_Id)
       AND (t5.m_Type = 'S')
       and acuhead."apar_id" (+) = t2.s_studentreference
       and agladdr."dim_value" (+) = acuhead."apar_id"
       and agladdr."attribute_id" (+) = 'A4'
       and agladdr."address_type" (+) = '1'
       and ltel.t_id (+) = s_studentlocaltelephon
      and t2.s_studentreference = '10538344'
      and agr_ho_status.agr_s_id (+) = t2.s_studentreference
)
where academicyear = (select ic_text2 from capd_institution i, capd_institutioncustom ic
                                       where nvl(i.i_end, to_date('31-dec-2099', 'DD-MON-YYYY')) > sysdate
                                       and ic_type = 'AGRESSO') 
and (agladdress is null
 or upper(rpad(replace(agladdress, '.', ' '), 160)) <> upper(replace(substr(aparline, 1158 , 160), '.', ' '))
or rpad(upper(nvl(aglemail, ' ')), 255) <> rpad(upper(substr(aparline, 2254, 255)), 255)
or rpad(upper(nvl(postcode, ' ')), 15) <> rpad(upper(aglzipcode), 15)
or rpad(upper(nvl(telephone1, ' ')), 35) <> upper(substr(aparline, 2009, 35))
or rpad(upper(nvl(compregno, ' ')), 25) <> upper(rpad(nvl(slcsupportnumber, ' '), 25))
or rpad(upper(nvl(agr_ho_status, ' ')), 25) <>  rpad(upper(nvl(unite_ho_status, ' ')), 25)
);