\c telpark

SHOW work_mem;
SHOW effective_cache_size;
SHOW shared_buffers;
SHOW temp_buffers;

SET work_mem = '512MB';
SET effective_cache_size = '16GB';
SET temp_buffers = '256MB';

\q

-- SET work_mem = '4MB';
-- SET effective_cache_size = '4GB';
-- SET temp_buffers = '8MB';