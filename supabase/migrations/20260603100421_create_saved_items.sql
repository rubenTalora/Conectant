-- Create saved_items table
CREATE TABLE IF NOT EXISTS saved_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  web VARCHAR(255),
  contact VARCHAR(255),
  address TEXT,
  description TEXT,
  type VARCHAR(50) NOT NULL CHECK (type IN ('entidad', 'centro')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE saved_items ENABLE ROW LEVEL SECURITY;

-- Create RLS policy: Users can only see their own items
CREATE POLICY "Users can view their own items"
  ON saved_items FOR SELECT
  USING (auth.uid() = user_id);

-- Create RLS policy: Users can only insert their own items
CREATE POLICY "Users can insert their own items"
  ON saved_items FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Create RLS policy: Users can only update their own items
CREATE POLICY "Users can update their own items"
  ON saved_items FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Create RLS policy: Users can only delete their own items
CREATE POLICY "Users can delete their own items"
  ON saved_items FOR DELETE
  USING (auth.uid() = user_id);

-- Create index on user_id for performance
CREATE INDEX IF NOT EXISTS saved_items_user_id_idx ON saved_items(user_id);
