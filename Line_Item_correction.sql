SELECT
    organizations.code,
    companies.erp_id,
    attachments.document_id,
    attachments.parsing_status,
    order_corrections.quote_number_original,
    order_corrections.quote_number_corrected,
    order_corrections.quote_number_status,
    order_corrections.po_number_original,
    order_corrections.po_number_corrected,
    order_corrections.po_date_original,
    order_corrections.po_date_corrected,
    order_corrections.doc_type_original,
    order_corrections.doc_type_corrected,
    order_corrections.po_delivery_date_original,
    order_corrections.po_delivery_date_corrected,
    line_item_corrections.unit_original,
    line_item_corrections.unit_corrected,
    line_item_corrections.quantity_original,
    line_item_corrections.quantity_corrected
FROM
    orders
    FULL OUTER JOIN attachments ON orders.attachment_id = attachments.id
    FULL OUTER JOIN order_corrections ON order_corrections.order_id = orders.id
    LEFT JOIN mails ON attachments.mail_id = mails.id
    LEFT JOIN companies ON mails.company_id = companies.id
    LEFT JOIN feedbacks_new ON feedbacks_new.attachment_id = attachments.id
    LEFT JOIN inbox_accounts ON mails.account = inbox_accounts.identifier
    LEFT JOIN organizations ON organizations.inbox_account_id = inbox_accounts.id
    LEFT JOIN line_items ON line_items.order_id = orders.id
    FULL OUTER JOIN line_item_corrections ON line_item_corrections.line_item_id = line_items.id
WHERE
    organizations.code = 'KCD'
    AND attachments.parser_type = 'iepo';
