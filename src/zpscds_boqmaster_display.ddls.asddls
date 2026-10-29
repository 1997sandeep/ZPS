@AbapCatalog.sqlViewName: 'ZPSBOQMASTERDSP'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Master Display'
define view ZPSCDS_BOQMASTER_DISPLAY
  //    with parameters parameter_name : parameter_type
  as select from zpst_boq_mast2
{
      @EndUserText.label: 'Project ID'
  key zpspnr             as Zpspnr,
      @EndUserText.label: 'Version'
  key zboq_version       as ZboqVersion,
      @EndUserText.label: 'BOQ Header No'
      zboq_head_no       as ZboqHeadNo,
      @EndUserText.label: 'BOQ Item No'
      zboq_item_no       as ZboqItemNo,
      @EndUserText.label: 'BOQ Qty'
      zboq_qty           as ZboqQty,
      @EndUserText.label: 'Unit'
      zunit              as Zunit,
      @EndUserText.label: 'Project Name'
      posid              as Posid,
      @EndUserText.label: 'Chain From'
      zdes_chain_from    as ZdesChainFrom,
      @EndUserText.label: 'Chain To'
      zdes_chain_to      as ZdesChainTo,
      @EndUserText.label: 'Chain At'
      zdes_chain_at      as ZdesChainAt,
      @EndUserText.label: 'BOQ Header Description'
      zboq_head_desc     as ZboqHeadDesc,
      @EndUserText.label: 'BOQ Item Description'
      zboq_item_desc     as ZboqItemDesc,
      @EndUserText.label: 'Currency Key'
      zcurr              as Zcurr,
      @EndUserText.label: 'BOQ Rate'
      @Semantics.amount.currencyCode: 'zcurr'
      zboq_rate          as ZboqRate,
      @EndUserText.label: 'Total Amount'
      ztotal_amt         as ZtotalAmt,
      @EndUserText.label: 'Project Element Text'
      zproj_ext          as ZProjext,
      @EndUserText.label: 'Material Number'
      material           as Material,
      zboq_head_wbs      as ZboqHeadWbs,
      zboq_vqty          as ZboqVqty,
      zboq_vamount       as ZboqVamount,
      zboq_vrate         as ZboqVrate,
      zboq_bill          as ZboqBill,
      zboq_billunit      as ZboqBillunit,
      plant              as Plant,
      contract_number    as Contract_number,
      contract_line_item as Contract_line_item,
      responsible_eng    as Responsible_eng,
      @Semantics.user.createdBy: true
      @EndUserText.label: 'Created By'
      created_by         as CreatedBy,
      //      @Semantics.systemDateTime.createdAt: true
      @EndUserText.label: 'Created At'
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      @EndUserText.label: 'Last Changed By'
      last_changed_by    as LastChangedBy,
      //      @Semantics.systemDateTime.lastChangedAt: true
      @EndUserText.label: 'Last Changed At'
      last_changed_at    as LastChangedAt,
      0                  as ExcelRowNumber
}
group by
  zpspnr,
  zboq_version,
  zboq_head_no,
  zboq_item_no,
  zboq_qty,
  zunit,
  posid,
  zdes_chain_from,
  zdes_chain_to,
  zdes_chain_at,
  zboq_head_desc,
  zboq_item_desc,
  zcurr,
  zboq_rate,
  ztotal_amt,
  zproj_ext,
  material,
  zboq_head_wbs,
  zboq_vqty,
  zboq_vamount,
  zboq_vrate,
  zboq_bill,
  zboq_billunit,
  plant,
  contract_number,
  contract_line_item,
  responsible_eng,
  created_by,
  created_at,
  last_changed_by,
  last_changed_at
