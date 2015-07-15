create or replace view uop_agr_workorder_view as 
SELECT DISTINCT
      'WORK'
      ||
      --desc
      --RPAD('T1', 25) || --client
      RPAD(instcustom.ic_text1, 25)
      ||
      --client
      RPAD(prog.m_reference, 25)
      ||
      --workorder
      RPAD('GBP', 25)
      ||
      --currency
      lpad('0', 25)
      ||
      --cust id
      rpad(/*'20090801'*/ to_char(agrproject."date_from", 'YYYYMMDD'), 8) -- get the date_from from the project in agresso rather than hard code it. tg 7/10/2011.
      ||
      -- date from
      rpad('20991231', 8)
      ||
      -- date to
      rpad(NVL(NVL(school.s_reference, faculty.d_reference), ' '), 25)
      ||
      -- department
      rpad(prog.m_name, 255)
      ||
      -- description
      rpad(' ', 25)
      ||
      -- dim1
      rpad(' ', 25)
      ||
      -- dim2
      rpad(' ', 25)
      ||
      -- dim3
      rpad(' ', 25)
      ||
      -- dim4
      rpad(' ', 8)
      ||
      -- expired date
      rpad(' ', 255)
      ||
      -- ext ord txt
      rpad(' ', 4)
      ||
      -- inv attr id
      rpad(' ', 1)
      ||
      -- inv flag
      rpad(' ', 1)
      ||
      -- inv status
      rpad(' ', 25)
      ||
      -- invoice code
      rpad(cc.cc_analysis, 25)
      ||
      -- project
      rpad(' ', 255)
      ||
      -- reference1
      rpad(' ', 25)
      ||
      -- resource id
      rpad('N', 1)
      ||
      -- status
      rpad(' ', 25)
      ||
      --user id
      'DESC'
      || 'EN'
      ||
      --language
      rpad(prog.m_name, 255)
      ||
      --description
      'RELA'
      || '62'
      ||
      -- relation 62
      '  '
      || rpad('X', 25)
      ||
      --rela62 value
      'RELA'
      || '87'
      ||
      -- relation 87
      '  '
      || rpad('X', 25)
      ||
      --rela87 value
      'RELA'
      || 'GK'
      ||
      -- relation GK
      '  '
      || rpad('NR', 25)
      ||
      --relaGK value
      'RELA'
      || '1069'
      --||
      -- relation 1069
      --'  '
      || rpad(' '), 25)
      -- rela 1069 value
      workorder_data 
        FROM
      capd_module prog                 ,
      capd_section school              ,
      capd_department faculty          ,
      capd_costcentre cc               ,
      capd_session sess                ,
      capd_institution inst            ,
      CAPD_INSTITUTIONCUSTOM INSTCUSTOM,
      --CAPD_MODULECUSTOM MODCUSTOM,
      "atsproject"@AGR55 agrproject
      WHERE
      prog.m_type                                 = 'P'
      AND prog.m_modulesession                    = sess.s_id
      AND m_modulecostcentre                      = cc.cc_id
      AND m_moduledept                            = faculty.d_id (+)
      AND cc.cc_analysis                         IS NOT NULL
      AND m_modulesection                         = school.s_id (+)
      AND inst.i_id                               = instcustom.ic_custominstitution
      AND instcustom.ic_type                      = 'AGRESSO'
      --AND prog.m_id                               = modcustom.mc_custommodule (+)
      --AND modcustom.mc_type (+)                   = 'GROUP'
      AND NVL(INST.I_END,'31-DEC-2099')           > SYSDATE
      AND NVL(PROG.M_END, TO_DATE('31-DEC-2099')) > SYSDATE
      AND AGRPROJECT."project" (+)               = CC.CC_ANALYSIS;
      --and prog.m_reference = '3905';
