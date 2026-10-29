@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CONSUME ROOT VIEW BOQ'
@Metadata.allowExtensions: true
define root view entity zpscds_boqroot1_param
  with parameters
    p_proj    : zproj_ext 
//    p_version : zversion hp
  as select from zpst_boq_mast2

{
         @EndUserText.label: 'Project ID'
  key    zpspnr          as Zpspnr,
         @EndUserText.label: 'Version'
  key    zboq_version    as ZboqVersion,
         @EndUserText.label: 'BOQ Header No'
         zboq_head_no    as ZboqHeadNo,
         @EndUserText.label: 'BOQ Item No'
         zboq_item_no    as ZboqItemNo,
         zboq_qty        as ZboqQty,
         zunit           as Zunit,
         posid           as Posid,
         zdes_chain_from as ZdesChainFrom,
         zdes_chain_to   as ZdesChainTo,
         zdes_chain_at   as ZdesChainAt,
         zboq_head_desc  as ZboqHeadDesc,
         zboq_item_desc  as ZboqItemDesc,
         zcurr           as Zcurr,
         @Semantics.amount.currencyCode: 'zcurr'
         zboq_rate       as ZboqRate,
         ztotal_amt      as ZtotalAmt,
         zproj_ext       as Zprojext,
         material        as Material,
         zboq_head_wbs   as ZboqHeadWbs,
         zboq_vqty       as ZboqVqty,
         zboq_vamount    as ZboqVamount,
         zboq_vrate      as ZboqVrate,
         zboq_bill       as ZboqBill,
         zboq_billunit   as ZboqBillunit,
         plant           as Plant,
         contract_number as Contract_number,
         contract_line_item as Contract_line_item,
         responsible_eng as Responsible_eng,
         created_by      as CreatedBy,
         created_at      as CreatedAt,
         last_changed_by as LastChangedBy,
         last_changed_at as LastChangedAt
}
where
//      zpspnr       = $parameters.p_proj
zproj_ext = $parameters.p_proj
//  and zboq_version = $parameters.p_version
