-- Create DIRECCION table (associations)
CREATE TABLE IF NOT EXISTS DIRECCION (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  type VARCHAR(50) DEFAULT '',
  description TEXT DEFAULT '',
  contact VARCHAR(255) DEFAULT '',
  website VARCHAR(255) DEFAULT ''
);

-- Create centros table
CREATE TABLE IF NOT EXISTS centros (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  address TEXT DEFAULT '',
  lat DOUBLE PRECISION DEFAULT 0,
  lng DOUBLE PRECISION DEFAULT 0,
  association_id UUID REFERENCES DIRECCION(id) ON DELETE CASCADE,
  description TEXT DEFAULT ''
);

-- Enable Row Level Security
ALTER TABLE DIRECCION ENABLE ROW LEVEL SECURITY;
ALTER TABLE centros ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for DIRECCION (allow public read)
CREATE POLICY "Allow public read access for DIRECCION"
  ON DIRECCION FOR SELECT
  USING (true);

-- Create RLS policies for centros (allow public read)
CREATE POLICY "Allow public read access for centros"
  ON centros FOR SELECT
  USING (true);

-- Create indexes
CREATE INDEX IF NOT EXISTS centros_association_id_idx ON centros(association_id);