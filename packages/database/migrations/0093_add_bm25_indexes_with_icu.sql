-- 1. Enable Postgres' built-in fuzzy search extension (Neon natively supports it, with no permission restrictions)
CREATE EXTENSION IF NOT EXISTS pg_trgm;
--> statement-breakpoint

-- 2. Clean up any old bm25 indexes that may remain
DROP INDEX IF EXISTS agents_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS topics_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS files_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS knowledge_bases_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS chat_groups_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_contexts_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_preferences_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_activities_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_identities_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memories_experiences_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS user_memory_persona_documents_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS documents_bm25_idx;--> statement-breakpoint
DROP INDEX IF EXISTS messages_bm25_idx;--> statement-breakpoint

-- 3. Create a native GIN TRGM fuzzy search index (for core high-frequency search fields)
CREATE INDEX IF NOT EXISTS agents_trgm_idx ON agents USING gin (title gin_trgm_ops, description gin_trgm_ops, system_role gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS topics_trgm_idx ON topics USING gin (title gin_trgm_ops, content gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS files_trgm_idx ON files USING gin (name gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS knowledge_bases_trgm_idx ON knowledge_bases USING gin (name gin_trgm_ops, description gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS user_memories_trgm_idx ON user_memories USING gin (title gin_trgm_ops, summary gin_trgm_ops, details gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS chat_groups_trgm_idx ON chat_groups USING gin (title gin_trgm_ops, description gin_trgm_ops, content gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS documents_trgm_idx ON documents USING gin (title gin_trgm_ops, description gin_trgm_ops, content gin_trgm_ops);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS messages_trgm_idx ON messages USING gin (content gin_trgm_ops, summary gin_trgm_ops);
