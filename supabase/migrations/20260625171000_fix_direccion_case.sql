-- Drop existing tables if needed
DROP TABLE IF EXISTS centros CASCADE;
DROP TABLE IF EXISTS direccion CASCADE;

-- Create tables with quoted uppercase names
CREATE TABLE "DIRECCION" (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  type VARCHAR(50) DEFAULT '',
  description TEXT DEFAULT '',
  contact VARCHAR(255) DEFAULT '',
  website VARCHAR(255) DEFAULT ''
);

CREATE TABLE "centros" (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  address TEXT DEFAULT '',
  lat DOUBLE PRECISION DEFAULT 0,
  lng DOUBLE PRECISION DEFAULT 0,
  association_id UUID REFERENCES "DIRECCION"(id) ON DELETE CASCADE,
  description TEXT DEFAULT ''
);

-- Enable RLS
ALTER TABLE "DIRECCION" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "centros" ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY allow_read ON "DIRECCION" FOR SELECT USING (true);
CREATE POLICY allow_read ON "centros" FOR SELECT USING (true);

-- Notify PostgREST to reload schema
NOTIFY pgrst, 'reload schema';