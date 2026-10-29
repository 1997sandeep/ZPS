@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR BOQ View for 1st time'
@Metadata.allowExtensions: true
define root view entity ZPS_DPRBOQ_LATEST 

  //  as select from    zpst_boq_mast2       as a1
  //    left outer join zpst_boqmast_version as a2 on  a1.zpspnr       = a2.zpspnr
  //                                               and a1.zboq_head_no = a2.zboq_head_no
  //                                               and a1.zboq_item_no = a2.zboq_item_no
  //                                               and a1.zboq_head_no = a2.zboq_head_no
  //                                               and a1.zboq_version = a2.ZboqVersion
  as select distinct from    ZPST_BOQMAST_VERSION1 as a2
    inner join      zpst_boq_mast2        as a1 on  a2.zpspnr      = a1.zpspnr
                                                and a2.ZboqVersion = a1.zboq_version
                                                and a2.posid       = a1.posid
    left outer join ZPS_DPR_PREV_QUAN     as a3 on a1.posid = a3.Posid
    left outer join ZPS_DPR_BOQ_VAL       as a4 on  a1.posid = a4.posid
                                                and a1.zproj_ext = a4.zproj_ext  
                                                and a1.zproj_ext = a4.zproj_ext  
                                                and a1.zboq_item_no = a4.zboq_item_no
                                                and a1.zboq_head_no = a4.zboq_head_no
  left outer join  I_EnterpriseProject as a on a.Project  = a1.zproj_ext
  left outer join  I_EnterpriseProjectElement as aa on aa.ProjectInternalID  = a.ProjectInternalID
                                                 and aa.ProjectElement = a1.posid
   
 

{
  key a1.zproj_ext,
  key a1.posid,
  key a1.zboq_version,
  key a1.zboq_head_no,
  key a1.zboq_item_no,
  key a1.zpspnr,
      a1.zboq_head_desc,
      a1.zboq_item_desc,
      cast(a1.zboq_rate as abap.dec( 12, 2 )) as zboq_rate ,
      a1.zunit,
      cast(a1.zboq_qty as abap.dec( 12, 2 )) as zboq_qty ,
//      a1.zboq_qty,
      a3.Zuom,
      @Semantics.quantity.unitOfMeasure: 'Zuom'

   
      a3.ZdprQty as zprev_qty,
      ''         as zdpr_flg,
      a4.zboq_qty as sum_boq,
      a4.zboq_tqty as sum_tboq,
      aa.PlannedStartDate as projectstartdate,
      aa.PlannedEndDate as projectenddate,
      aa.ActualStartDate as actualstartdate,
      aa.ActualFinishDate as actualfinishdate,
      a1.responsible_eng
}
group by
  a1.posid,
  a1.zboq_head_no,
  a1.zboq_item_no,
  a1.zboq_head_desc,
  a1.zboq_item_desc,
  a1.zunit,
  a1.zboq_qty,
  a1.zproj_ext,
  a1.zboq_version,
  a1.zpspnr,
  a3.Zuom,
  a3.ZdprQty,
    a4.zboq_qty,
    a4.zboq_tqty,
//   aa.PlannedStartDate,
//   aa.PlannedEndDate,
//   aa.ActualStartDate,
//   aa.ActualFinishDate,
   a1.responsible_eng,
    a1.zboq_rate,
    aa.PlannedStartDate,
    aa.PlannedEndDate,
    aa.ActualStartDate,
    aa.ActualFinishDate
