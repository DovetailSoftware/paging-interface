/*************************************************************************
 *
 * $Header: /fchoice/product/paging/schema/pg_schema.sch 18    6/10/02 2:01p Dsirkin $
 *
 * Product        :  Paging Interface
 *                                                                          
 * Name           :  pg.sch
 *                                                                           
 * Description    :  This partial schema file provides information required
 *                   required to update a Clarify schema for the Paging Interface
 *                   product.
 *
 *                   In this partial schema file is:
 * 
 *                   * Two new fields to be applied to table_employee
 *                   * One new relation to be applied to table_employee
 *                   * One new relation to be applied to table_case
 *                   * One new relation to be applied to table_subcase
 *                   * Two new tables: table_page_request & table_page_response
 *                   * Six new tables for the internationalization objects
 *                        fc_string      
 *                        fc_list_hdr    
 *                        fc_list_level  
 *                        fc_list_elm    
 *                        fc_list_locelm 
 *                        fc_locale      
 *      
 *                   Use a text editor to cut+paste these changes into
 *                   a current Clarify schema file.
 *
 * Usage          :  * Use the Clarify Data Dictionary Editor to export a schema file
 *                   * Use a text editor to cut+paste these changes into the file
 *                   * Use the Data Dictionary Editor to apply the schema file
 *
 * Author         :  First Choice Software, Inc.                             
 *                   4412 Spicewood Springs Road Suite 701
 *                   Austin, TX  78759                                       
 *                   (512) 418-2905                                          
 *                                                                           
 * Platforms      :  This version supports Clarify 4.5 and later             
 *                                                                           
 * Copyright (C)  1998 First Choice Software, Inc.                           
 * All Rights Reserved                                                       
 *************************************************************************/

/*
 * Add the following as the last fields in OBJECT employee
 */
,
    x_pg_custname  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=8
     COMMENT="Customer Name provided by RPA"
,
    x_pg_custid  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=7
     COMMENT="Customer ID provided by RPA"
/*
 * Add the following relations as the last relations in OBJECT employee
 */
,
    employee2page_request OTM page_request USER_DEFINED
     INV_REL=page_request2employee     COMMENT="Page requests for this employee"

/*
 * Add the following relations as the last relations in OBJECT act_entry
 */
,
    act_entry2page_request MTO page_request USER_DEFINED
     INV_REL=page_request2act_entry     COMMENT="Activity log entries for the page request"

/*
 * Add the following relations as the last relations in OBJECT case
 */
,
    case2page_request OTM page_request USER_DEFINED
     INV_REL=page_request2case     COMMENT="Page requests for this case"

/*
 * Add the following relations as the last relations in OBJECT subcase
 */
,
    subcase2page_request OTM page_request USER_DEFINED
     INV_REL=page_request2subcase     COMMENT="Page requests for this subcase"

/*
 * Add the following tables/view to the schema
 */

OBJECT page_request 3550
 SUBJECT="FC Paging"
 COMMENT="Request record for First Choice Software page object"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
,
    creation_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date/time record was created"
,
    request_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date/time page request was submitted to Paging Serial Interface"
,
    type  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="Page type. 0 = API (ad-hoc) Request. 1 = Business Rule Pager Notification"
,
    device_num  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=40
     COMMENT="Pager or device number"
,
    message  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=8
     OPTIONAL USER_DEFINED
     COMMENT="Message sent to pager"
,
    last_response_code  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
     COMMENT="Last response received from RPA"
,
    last_response_date  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date of last response received from RPA"
,
    is_closed  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="0=page request is open; 1=page request is closed. The interpretation of an open vs. closed page request is customer specific."
,
    arch_ind  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="When set to 1, indicates the object is ready for purge/archive"

  FIELDS_END
  RELATIONS
    page_request2case MTO case USER_DEFINED
     INV_REL=case2page_request     COMMENT=" "
,
    page_request2subcase MTO subcase USER_DEFINED
     INV_REL=subcase2page_request     COMMENT=" "
,
    page_request2employee MTO employee USER_DEFINED
     INV_REL=employee2page_request     COMMENT=" "
,
    page_request2page_response OTM page_response USER_DEFINED
     INV_REL=page_response2page_request     COMMENT=" "
,
    page_request2act_entry OTM act_entry USER_DEFINED
     INV_REL=act_entry2page_request      COMMENT=" "

  RELATIONS_END
OBJECT_END;

OBJECT page_response 3551
 SUBJECT="FC Paging"
 COMMENT="Response record for First Choice Software page object"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
,
    creation_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date/time response was processed"
,
    response_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date/time response file was created by RPA"
,
    response_code  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
     COMMENT="RPA response code"
,
    response_reason  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
     COMMENT="RPA response reason"
,
    response_addr  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=40
     COMMENT="End-user device address"
,
    delivery_time  CMN_DATA_TYPE="clk_ty_time" DB_DATA_TYPE=9
     OPTIONAL USER_DEFINED
     COMMENT="Date/time message was delivered (DL code only)"
,
    confirmation  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=100
     COMMENT="Confirmation message returned by field engineer (CF code only)"

  FIELDS_END
  RELATIONS
    page_response2page_request MTO page_request USER_DEFINED
     INV_REL=page_request2page_response     COMMENT="Relation to page request."

  RELATIONS_END
OBJECT_END;

VIEW view_pages 3552
 SUBJECT="Page Requests"
 COMMENT="Page Requests with linked record information."
  FIELDS
   emp_objid  FROM	employee.objid
     COMMENT="Employee internal record number",
   emp_last_name  FROM	employee.last_name
     COMMENT="Employee Last Name",
   emp_first_name  FROM	employee.first_name
     COMMENT="Employee First Name",
   page_objid 	FROM	page_request.objid     UNIQUE
     COMMENT="Page Request internal record number",
   page_req_time	FROM	page_request.request_time
     COMMENT="Page Request Date/Time",
   page_resp_time	FROM	page_request.last_response_date
     COMMENT="Page Last Response Date/Time",
   page_resp_code	FROM	page_request.last_response_code
     COMMENT="Page Last Response Code",
   page_device_num	FROM	page_request.device_num
     COMMENT="Page Device Number",
   page_message	FROM	page_request.message
     COMMENT="Page Message",
   page_is_closed	FROM	page_request.is_closed
     COMMENT="Page Closed Indicator",
   case_id_number	FROM	case.id_number
     COMMENT="Case ID number",
   case_objid	FROM	case.objid
     COMMENT="Case internal record number",
   subcase_id_number	FROM	subcase.id_number
     COMMENT="Subcase ID number",
   subcase_objid	FROM	subcase.objid
     COMMENT="Subcase internal record number"
  FIELDS_END
  JOINS
   OUTER employee.employee2page_request = page_request.page_request2employee
    COMMENT="",
   OUTER case.case2page_request = page_request.page_request2case
    COMMENT="",
   OUTER subcase.subcase2page_request = page_request.page_request2subcase
    COMMENT=""
  JOINS_END
VIEW_END;


OBJECT fc_string 3500
 SUBJECT="System"
 COMMENT="Locale-based strings for First Choice Software Customizations"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    id  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="String ID"
,
    string  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Text  of the string"
,
    locale  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Indicates the locale of the string; e.g., EN_US=US English, JA_JP=Japanese in Japan"
,
    application  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
OBJECT_END;

OBJECT fc_list_hdr 3501
 SUBJECT="FC I18N"
 COMMENT="Header record for First Choice Software list object"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    title  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Name of the list"
,
    description  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Description of the list"
,
    application  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="What is the list for?"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    hdr2fc_list_level OTOP fc_list_level USER_DEFINED
     INV_REL=level2fc_list_hdr     COMMENT="Top-level of list"

  RELATIONS_END
OBJECT_END;

OBJECT fc_list_level 3502
 SUBJECT="FC I18N"
 COMMENT="One level of a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    level2fc_list_elm OTM fc_list_elm USER_DEFINED
     INV_REL=elm2fc_list_level     COMMENT="Elements for this list level"
,
    level2fc_list_hdr OTOF fc_list_hdr USER_DEFINED
     INV_REL=hdr2fc_list_level     COMMENT="Relates top level to header"
,
    child2fc_list_elm OTOF fc_list_elm USER_DEFINED
     INV_REL=parent2fc_list_level     COMMENT="The element that this level was called from"

  RELATIONS_END
OBJECT_END;

OBJECT fc_list_elm 3503
 SUBJECT="FC I18N"
 COMMENT="One element in a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    rank  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="The position of this element in the level"
,
    state  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="The state of the element. 0 = Default. 1 = Active. 2 = Inactive"
,
    fc_use  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Only used by the i18n list gui. Do not depend on this field having a value."
,
    fc_use2  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Only used by the i18n list gui. Do not depend on this field having a value."
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    elm2fc_list_level MTO fc_list_level USER_DEFINED
     INV_REL=level2fc_list_elm     COMMENT="Level for this element"
,
    parent2fc_list_level OTOP fc_list_level USER_DEFINED
     INV_REL=child2fc_list_elm     COMMENT="The sub-level for this element"
,
    locs2fc_list_locelm OTM fc_list_locelm USER_DEFINED
     INV_REL=locelm2fc_list_elm     COMMENT="The locale strings for this element"
  RELATIONS_END
OBJECT_END;

OBJECT fc_list_locelm 3504
 SUBJECT="FC I18N"
 COMMENT="One locale string for an element in a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    title  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="String for the locale element"
,
    locale  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Locale for the locale element"
,
    other  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Other string for the locale element"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    locelm2fc_list_elm MTO fc_list_elm USER_DEFINED
     INV_REL=locs2fc_list_locelm     COMMENT="Element for this locale string"

  RELATIONS_END
OBJECT_END;

OBJECT fc_locale 3505
 SUBJECT="System"
 COMMENT=" "
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    locale_name  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    abday  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    day  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    abmon  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    mon  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    d_t_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    d_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    t_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    am_pm  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    t_fmt_ampm  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    upper  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    lower  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    space  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    cntrl  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    punct  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    digit  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    xdigit CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    blank  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    toupper  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    tolower  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    yesexpr  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    noexpr  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    int_curr_symbol  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    currency_symbol  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_decimal_point  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_thousands_sep  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_grouping  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED COMMENT=""
,
    positive_sign  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    negative_sign  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    int_frac_digits  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    frac_digits  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_cs_precedes  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_sep_by_space  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_cs_precedes  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_sep_by_space  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_sign_posn  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_sign_posn  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    decimal_point  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    thousands_sep  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    grouping  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
OBJECT_END;

/*
 * That's it.
 */
