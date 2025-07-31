//@EndUserText.label: 'Tmg For Process Issue Slip Master Table'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@ObjectModel.semanticKey: [ 'SingletonID' ]
//@UI: {
//  headerInfo: {
//    typeName: 'TmgForProcessIssAll'
//  }
//}
@EndUserText.label: 'Tmg For Process Issue Slip Master Table'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZI_TmgForProcessIssueS_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_MACHINEWISEANALYSIS'
  composition [0..*] of ZI_TmgForProcessIssueS as _TmgForProcessIssueS
//  as select from I_Language
//    left outer join ZPROCESS_ISSUE on 0 = 0
//  association [0..*] to I_ABAPTransportRequestText as _I_ABAPTransportRequestText on $projection.TransportRequestID = _I_ABAPTransportRequestText.TransportRequestID
//  composition [0..*] of ZI_TmgForProcessIssueS as _TmgForProcessIssueS

{
  key 1 as SingletonID,
  _TmgForProcessIssueS,
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  cast( '' as sxco_transport) as TransportRequestID,
  cast( 'X' as abap_boolean preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
//  @UI.facet: [ {
//    id: 'ZI_TmgForProcessIssueS', 
//    purpose: #STANDARD, 
//    type: #LINEITEM_REFERENCE, 
//    label: 'Tmg For Process Issue Slip Master Table', 
//    position: 1 , 
//    targetElement: '_TmgForProcessIssueS'
//  } ]
//  @UI.lineItem: [ {
//    position: 1 
//  } ]
//  key 1 as SingletonID,
//  _TmgForProcessIssueS,
//  @UI.hidden: true
//  max( ZPROCESS_ISSUE.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
//  @ObjectModel.text.association: '_I_ABAPTransportRequestText'
//  @UI.identification: [ {
//    position: 2 , 
//    type: #WITH_INTENT_BASED_NAVIGATION, 
//    semanticObjectAction: 'manage'
//  } ]
//  @Consumption.semanticObject: 'CustomizingTransport'
//  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
//  _I_ABAPTransportRequestText
//  
//}
//where I_Language.Language = $session.system_language
