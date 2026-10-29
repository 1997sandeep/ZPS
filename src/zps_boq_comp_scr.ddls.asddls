@AbapCatalog.sqlViewName: 'ZPSBOQVERNCOMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ version comparion screen'
define view ZPS_BOQ_COMP_SCR
  with parameters
    p_proj    : zproj_ext,
    p_version : zversion,
    p_vers1   : zversion //HS on 04.09.2026
//    p_zboq_from : zdats, //HS on 04.09.2026
//    p_zboq_to   : zdats   //HS on 04.09.2026  
  as select distinct from    zpst_boq_mast2  as a 
    left outer join ZPSCDS_BOQROOT1 as b on  b.Zpspnr       = a.zpspnr
                                         and b.ZboqVersion = $parameters.p_version
                                         and b.ZboqHeadNo = a.zboq_head_no
                                         and b.ZboqItemNo = a.zboq_item_no
                                         and b.Posid = a.posid 
    left outer join ZPSCDS_BOQROOT1 as c on  c.Zpspnr       = a.zpspnr
                                         and c.ZboqVersion = '001'
                                         and c.ZboqHeadNo = a.zboq_head_no
                                         and c.ZboqItemNo = a.zboq_item_no
                                         and c.Posid = a.posid
    left outer join I_EnterpriseProjectElement as d on  d.ProjectElement = a.posid
    left outer join ZPS_BOQ_COMP_SCR_ACT          //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  //HS on 04.09.2026
                                    as e on  e.WBSElementInternalID = d.WBSElementInternalID                                                  
    left outer join ZPS_BOQ_COMP_SCR_ACT_FINAL //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to ) //HS on 04.09.2026
                                        as g on  g.WBSElementInternalID = d.WBSElementInternalID 
    left outer join ZPS_BOQ_COMP_SCR_ACT_FINAL1 //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to ) //HS on 04.09.2026
                                        as h on  h.WBSElementInternalID = d.WBSElementInternalID 

////    left outer join ZPS_BOQ_COMP_SCR_ACT2( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
////                                    as g on  g.WBSElementInternalID = d.WBSElementInternalID                                                  
////    left outer join ZPS_BOQ_COMP_SCR_ACT3( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
////                                    as h on  h.WBSElementInternalID = d.WBSElementInternalID                                                  
    left outer join ZPS_BOQ_COMP_SCR_DPR  //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to ) //HS on 04.09.2026
                                    as f on f.posid = a.posid
{
         @EndUserText.label: 'Project ID'
  key    a.zpspnr          as Zpspnr,
         @EndUserText.label: 'Version'
  key    a.zboq_version    as ZboqVersion,
         @EndUserText.label: 'BOQ From'
         a.posid           as Posid,
         a.zboq_from        as ZboqFrom,
         @EndUserText.label: 'BOQ To'
         a.zboq_to         as ZboqTo,
         @EndUserText.label: 'BOQ Level'
         a.zboq_level        as ZboqLevel,
         @EndUserText.label: 'BOQ Header No'
         a.zboq_head_no    as ZboqHeadNo,
         @EndUserText.label: 'BOQ Item No'
         a.zboq_item_no    as ZboqItemNo,
////         a.zboq_qty        as ZboqQty,
//         a.ztotal_amt      as ZtotalAmt,
         c.ZboqQty,
         c.ZtotalAmt,
         a.zunit           as Zunit,
         a.zdes_chain_from as ZdesChainFrom,
         a.zdes_chain_to   as ZdesChainTo,
         a.zdes_chain_at   as ZdesChainAt,
         a.zboq_head_desc  as ZboqHeadDesc,
         a.zboq_item_desc  as ZboqItemDesc,
         a.zcurr           as Zcurr,
         @Semantics.amount.currencyCode: 'zcurr'
         a.zboq_rate       as ZboqRate,
         a.zproj_ext       as Zprojext,
         a.material        as Material,
         a.zboq_head_wbs   as ZboqHeadWbs,
//         b.ZboqQty         as ZboqVqty,
//         b.ZtotalAmt       as ZboqVamount,
//         b.ZboqRate        as ZboqVrate,
         a.zboq_vqty       as ZboqVqty,
         a.zboq_vamount    as ZboqVamount,
         a.zboq_vrate      as ZboqVrate,
         @Semantics.quantity.unitOfMeasure : 'zunit'
         f.zcuml_qty           as ZboqTqty,
         e.AdditionalCurrency1,
//         @Semantics.amount.currencyCode: 'AdditionalCurrency1' 
         e.AmountInCompanyCodeCurrency,
         g.ZboqTamount as ZboqTamount1,
         h.ZboqTamount as ZboqTamount,
////         case
////         when e.AmountInCompanyCodeCurrency is not null and  g.ZboqTamount is null 
////         then e.AmountInCompanyCodeCurrency
////         when e.AmountInCompanyCodeCurrency is null and  g.ZboqTamount is not null 
////         then g.ZboqTamount
////
////         when e.AmountInCompanyCodeCurrency is not null and  g.ZboqTamount is not null 
////         then e.AmountInCompanyCodeCurrency + g.ZboqTamount  
////
////         else 0.00
////         end as ZboqTamount ,
////         e.AmountInCompanyCodeCurrency + g.GoodsIssueAmountInCoCodeCrcy + h.TotalGoodsMvtAmtInCCCrcy  as ZboqTamount,
         a.plant           as plant,
         a.contract_number as contract_number,
         a.contract_line_item as contract_line_item,
         a.responsible_eng as responsible_eng, 
         a.zboq_trate      as ZboqTrate,
         a.zboq_blqty      as ZboqBlqty,
         a.zboq_blamount   as ZboqBlamount,
         a.zboq_blrate     as ZboqBlrate,
         a.zboq_bill       as ZboqBill,
         a.zboq_billunit   as ZboqBillunit,
         '0.00'            as qty_var,
         '0.00'            as cost_var,
         a.created_by        as CreatedBy,
         a.created_at        as CreatedAt,
         a.last_changed_by   as LastChangedBy,
         a.last_changed_at   as LastChangedAt
}
where
//      a.zpspnr       = $parameters.p_proj
a.zproj_ext = $parameters.p_proj
and a.zboq_version = $parameters.p_vers1 //HS on 04.09.2026
 