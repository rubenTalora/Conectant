-- Create a test user for saved_items
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at, updated_at) 
VALUES ('00000000-0000-0000-0000-000000000000', 'test@test.com', '$2a$10$abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHI', NOW(), NOW(), NOW())
ON CONFLICT (id) DO NOTHING;