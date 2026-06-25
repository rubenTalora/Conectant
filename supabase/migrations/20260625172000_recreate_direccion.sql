-- Drop the uppercase table
DROP TABLE IF EXISTS "DIRECCION" CASCADE;

-- Create table in lowercase (standard PostgreSQL behavior)
CREATE TABLE direccion (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  type VARCHAR(50) DEFAULT '',
  description TEXT DEFAULT '',
  contact VARCHAR(255) DEFAULT '',
  website VARCHAR(255) DEFAULT ''
);

-- Enable RLS
ALTER TABLE direccion ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY allow_read ON direccion FOR SELECT USING (true);

-- Notify PostgREST
NOTIFY pgrst, 'reload schema';