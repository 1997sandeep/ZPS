CLASS zcl_dpr_doc_deletion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DPR_DOC_DELETION IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

*SELECT * FROM ZSD_SEQ_WISE_REVENUE_GL_REP
*WHERE BillingDocument IS NOT INITIAL
*INTO TABLE @data(lt).
*
*DATA(lt_) = lt[].
*      SELECT *
*        FROM zpst_scp_dpr_r1
*        WHERE zappr_status = 'APPR'
*        INTO TABLE @DATA(lt_dpr).
*
*      READ TABLE lt_dpr INTO DATA(lw_dpr)
*        WITH KEY zdpr_no = '0000000537'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000536'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000535'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000534'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000533'
*                 zpspnr   = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000532'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000530'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000529'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000522'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000519'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000518'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000517'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000516'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000515'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000514'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000513'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000512'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000510'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000507'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000506'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000504'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000503'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000502'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000501'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000500'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000499'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '000000485'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000484'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000483'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000482'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000481'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000480'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000479'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000478'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000477'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000476'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000475'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000474'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000473'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000472'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000471'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000470'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000469'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000468'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000467'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000466'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000465'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000464'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000463'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000462'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000461'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000460'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000459'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000458'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000457'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000456'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000455'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000454'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000453'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000452'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000451'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000450'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000449'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000448'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000447'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000446'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000445'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000444'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000443'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000442'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000441'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000440'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000439'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000438'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000437'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000436'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000435'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000434'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000433'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000432'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000431'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000430'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000429'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000428'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000427'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000426'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000425'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000424'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000423'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000422'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000421'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000420'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000419'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000418'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000417'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000416'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000415'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000414'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000413'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000412'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000411'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000410'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000409'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000408'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000407'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000406'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000405'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000404'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000403'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000402'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000401'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000400'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000399'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000398'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000397'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000396'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000395'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000394'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000393'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000392'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000391'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000390'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000389'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000388'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000387'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000386'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000385'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000384'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000383'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000382'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000381'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000380'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000379'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000378'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000377'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000376'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000375'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000374'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000373'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000372'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000371'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000370'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000369'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000368'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000367'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000366'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000365'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000364'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000363'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000362'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000361'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000360'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000359'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000358'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000357'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000356'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000355'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000354'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000353'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000352'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000351'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000350'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000349'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000348'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000347'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000346'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000345'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000344'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000343'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000342'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000341'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000340'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000339'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000338'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000337'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000336'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000335'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000334'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000333'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000332'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000331'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000330'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000329'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000328'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000327'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000326'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000325'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000324'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000323'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000322'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000321'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000320'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000319'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000318'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000317'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000316'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000315'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000314'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000313'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000312'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000311'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000310'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000309'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000308'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000118'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000109'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*      READ TABLE lt_dpr INTO lw_dpr
*        WITH KEY zdpr_no = '0000000108'
*                 zpspnr  = '00000006'.
*      IF lw_dpr IS NOT INITIAL.
*        clear lw_dpr-zappr_status.
*        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
*      ENDIF.
*
*
*
*
*




    ENDMETHOD.
ENDCLASS.
