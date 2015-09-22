# Paging Interface

Paging Interface adds enhanced paging connectivity to the Clarify family of applications.

It is a ClearBasic-based product that works in conjunction with the Clarify Classic Client.

Many Clarify customers already use RPA (Radio Page America) as a paging service. RPA allows customers to use a single point of contact (and single protocol) to perform sophisticated paging operations. RPA uses store and forward technology to handle all of the complicated problems associated with employees who use many different pager services and levels of support. Other Clarify customers use PageMate as their paging service. Version 1.3 and later versions of the FCS Paging Interface includes PageMate support. PageMate does not provide two-way messaging, so some features provided may not apply for PageMate.

This interface provides basic paging capabilities with Clarify and RPA or PageMate:

* Notifications/escalations (from business rules) that should be sent via pager will be sent automatically via the Paging Interface through to the paging service.

In addition, this interface provides several new capabilities that enhance the Clarify paging system:

* The ability to send ad-hoc pages. These are pages that are sent at any time for any purpose, and are not tied at all to the business rule system.
* A new GUI form that allows a user to send a page related to a specific case, subcase, or employee.
* A new page monitor form that allows a user to view pages that have been sent, and responses that have been received (for two-way paging).
* A new API that can be customized in Clarify forms to send hard-coded pages at any time.
* APIs that allow the page monitor or page request forms to be displayed from any customization.
* Business rule support that allow for business rules to be fired on the page request or page response events.

The interface is extremely configurable. Each page request can optionally be tracked in the database, and any responses that RPA sends back can also be tracked. Activity log entries can be made when pages are made in relation to cases, subcases, and employees. Business rules can be added that will perform actions based on requests or actual/expected responses. Responses can be filtered so that only certain types are stored in the database.

## Documentation 
Documentation is located in the docs directory
