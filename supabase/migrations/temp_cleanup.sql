-- Delete test data (user_id = 00000000-0000-0000-0000-000000000000)
DELETE FROM saved_items WHERE user_id = '00000000-0000-0000-0000-000000000000';
NOTIFY pgrst, 'reload schema';