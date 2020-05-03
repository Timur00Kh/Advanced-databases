SELECT * FROM lab18_hub
    JOIN lab18_1 ON id = lab18_1.hub_id
    JOIN lab18_2 ON id = lab18_2.hub_id
    JOIN lab18_3 ON id = lab18_3.hub_id
    JOIN lab18_4 ON id = lab18_4.hub_id
    JOIN lab18_5 ON lab18_4.hub_id = hub4_id;