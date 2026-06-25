ALTER TABLE saved_items DISABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users can view their own items" ON saved_items;
DROP POLICY IF EXISTS "Users can insert their own items" ON saved_items;
DROP POLICY IF EXISTS "Users can update their own items" ON saved_items;
DROP POLICY IF EXISTS "Users can delete their own items" ON saved_items;
NOTIFY pgrst, 'reload schema';