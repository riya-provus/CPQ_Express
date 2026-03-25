# CPQ Express – Salesforce Quote Management Automation

## Project Description
CPQ Express is a Salesforce Apex-based automation project developed to manage Quote approvals, discount validation, and Opportunity stage automation. The system enforces approval rules, prevents excessive discounts, and automatically updates Opportunity stages when Quotes are approved.

This project is built using Apex Classes, Triggers, and Test Classes following Salesforce best practices.

---

## Project Structure
```
cpq_express
│
├── classes
│   ├── ApprovalTest.cls
│   ├── DiscountTriggerTest.cls
│   ├── OnlyManagerApprovalHandler.cls
│   ├── QuoteLineItemHandler.cls
│   ├── QuoteOpportunityHandler.cls
│   ├── QuoteOpportunityHandlerTest.cls
│
├── triggers
│   ├── ApprovalTrigger.trigger
│   ├── DiscountExceedTrigger.trigger
│
└── README.md
```
---

## Features Implemented

### 1. Quote Approval Authorization
- Only Manager/System Administrator can approve Quotes.
- If another user tries to approve a Quote, an error is shown.

### 2. Discount Validation
- Prevents discount from exceeding allowed limit on Quote Line Items.
- Stops user from saving record if discount is too high.

### 3. Opportunity Stage Automation
- When all Quotes related to an Opportunity are Approved,
  Opportunity Stage automatically updates to Closed Won.

---

## Triggers Used

| Trigger Name | Object | Event | Purpose |
|--------------|--------|-------|---------|
| ApprovalTrigger | Quote | Before Update | Restrict quote approval |
| DiscountExceedTrigger | QuoteLineItem | Before Insert/Update | Validate discount |
| Quote Opportunity Logic | Quote | After Update | Update Opportunity Stage |

---

## Apex Classes

| Class Name | Purpose |
|------------|---------|
| OnlyManagerApprovalHandler | Restricts quote approval to manager |
| QuoteLineItemHandler | Validates discount limits |
| QuoteOpportunityHandler | Updates Opportunity stage |
| ApprovalTest | Test class for approval logic |
| DiscountTriggerTest | Test class for discount logic |
| QuoteOpportunityHandlerTest | Test class for opportunity update |

---

## Business Logic Flow
Quote Created → Submitted → Approved (Manager Only)
        ↓
Discount Validation on Quote Line Items
        ↓
All Quotes Approved
        ↓
Opportunity Stage → Closed Won

---

## Technologies Used
- Salesforce CRM
- Apex
- SOQL
- Apex Triggers
- Test Classes
- VS Code
- Salesforce CLI

---

## Author
CPQ Express – Salesforce Automation Project
