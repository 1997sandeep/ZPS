@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ROOT VIEW FOR FOR BOQ PROCESS'
@Metadata.allowExtensions: true
define root view entity ZPSCDS_BOQROOT1
  as select from zpst_boq_mast2

{
      @EndUserText.label: 'Project ID'
  key zpspnr          as Zpspnr,
      @EndUserText.label: 'Version'
  key zboq_version    as ZboqVersion,
      @EndUserText.label: 'BOQ Header No'
  key zboq_head_no    as ZboqHeadNo,
      @EndUserText.label: 'BOQ Item No'
  key zboq_item_no    as ZboqItemNo,
      @EndUserText.label: 'BOQ From'
      zboq_from        as ZboqFrom,
      @EndUserText.label: 'BOQ To'
      zboq_to         as ZboqTo,
      @EndUserText.label: 'BOQ Level'
      zboq_level        as ZboqLevel,
      @EndUserText.label: 'BOQ Qty'
      zboq_qty        as ZboqQty,
      @EndUserText.label: 'Unit'
      zunit           as Zunit,
      @EndUserText.label: 'Project Name'
      posid           as Posid,
      @EndUserText.label: 'Chain From'
      zdes_chain_from as ZdesChainFrom,
      @EndUserText.label: 'Chain To'
      zdes_chain_to   as ZdesChainTo,
      @EndUserText.label: 'Chain At'
      zdes_chain_at   as ZdesChainAt,
      @EndUserText.label: 'BOQ Header Description'
      zboq_head_desc  as ZboqHeadDesc,
      @EndUserText.label: 'BOQ Item Description'
      zboq_item_desc  as ZboqItemDesc,
      @EndUserText.label: 'Currency Key'
      zcurr           as Zcurr,
      @EndUserText.label: 'BOQ Rate'
      @Semantics.amount.currencyCode: 'zcurr'
      zboq_rate       as ZboqRate,
      @EndUserText.label: 'Total Amount'
      ztotal_amt      as ZtotalAmt,
      @EndUserText.label: 'Project Element Text'
      zproj_ext       as ZProjext,
      @EndUserText.label: 'Material Number'
      material        as Material,
      zboq_head_wbs   as ZboqHeadWbs,
      zboq_vqty       as ZboqVqty,
      zboq_vamount    as ZboqVamount,
      zboq_vrate      as ZboqVrate,
      zboq_tqty       as ZboqTqty,
      zboq_tamount    as ZboqTamount,
      zboq_trate      as ZboqTrate,
      zboq_blqty      as ZboqBlqty,
      zboq_blamount   as ZboqBlamount,
      zboq_blrate     as ZboqBlrate,
      zboq_bill       as ZboqBill,
      zboq_billunit   as ZboqBillunit,
      plant              as   Plant             ,
      contract_number    as   Contract_number,
      contract_line_item as   Contract_line_item,
      responsible_eng    as   Responsible_eng   ,
      @Semantics.user.createdBy: true
      @EndUserText.label: 'Created By'
      created_by      as CreatedBy,
//      @Semantics.systemDateTime.createdAt: true
      @EndUserText.label: 'Created At'
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      @EndUserText.label: 'Last Changed By'
      last_changed_by as LastChangedBy,
//      @Semantics.systemDateTime.lastChangedAt: true
      @EndUserText.label: 'Last Changed At'
      last_changed_at as LastChangedAt,
      0               as ExcelRowNumber,
      ' ' as flag
}
