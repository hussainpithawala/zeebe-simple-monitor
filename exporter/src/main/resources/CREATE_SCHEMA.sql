DROP INDEX IF EXISTS WORKFLOW_KEY_INDEX;
DROP INDEX IF EXISTS WORKFLOW_INSTANCE_WORKFLOW_KEY_INDEX;
DROP INDEX IF EXISTS ACTIVITY_WORKFLOW_INSTANCE_KEY_INDEX;
DROP INDEX IF EXISTS INCIDENT_WORKFLOW_INSTANCE_KEY_INDEX;

CREATE TABLE IF NOT EXISTS WORKFLOW
(
  ID_ VARCHAR PRIMARY KEY,
  KEY_ BIGINT,
  BPMN_PROCESS_ID_ VARCHAR,
  VERSION_ INT,
  RESOURCE_ VARCHAR,
  TIMESTAMP_ BIGINT
);

CREATE INDEX WORKFLOW_KEY_INDEX ON WORKFLOW(KEY_) ;

CREATE TABLE IF NOT EXISTS WORKFLOW_INSTANCE
(
	ID_ VARCHAR PRIMARY KEY,
	PARTITION_ID_ INT,
	KEY_ BIGINT,
  BPMN_PROCESS_ID_ VARCHAR,
  VERSION_ INT,
	WORKFLOW_KEY_ BIGINT,
  START_ BIGINT,
  END_ BIGINT
);

CREATE INDEX WORKFLOW_INSTANCE_WORKFLOW_KEY_INDEX ON WORKFLOW_INSTANCE(WORKFLOW_KEY_);

CREATE TABLE IF NOT EXISTS ACTIVITY_INSTANCE
(
	ID_ VARCHAR PRIMARY KEY,
	PARTITION_ID_ INT,
	KEY_ BIGINT,
	INTENT_ VARCHAR,
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_ID_ VARCHAR,
	SCOPE_INSTANCE_KEY_ BIGINT,
	PAYLOAD_ VARCHAR,
	WORKFLOW_KEY_ BIGINT,
  TIMESTAMP_ BIGINT
);

CREATE INDEX ACTIVITY_WORKFLOW_INSTANCE_KEY_INDEX ON ACTIVITY_INSTANCE(WORKFLOW_INSTANCE_KEY_);

CREATE TABLE IF NOT EXISTS INCIDENT
(
	ID_ VARCHAR PRIMARY KEY,
	KEY_ BIGINT,
	INTENT_ VARCHAR,
	WORKFLOW_INSTANCE_KEY_ BIGINT,
	ACTIVITY_INSTANCE_KEY_ BIGINT,
	JOB_KEY_ BIGINT,
	ERROR_TYPE_ VARCHAR,
	ERROR_MSG_ VARCHAR,
  TIMESTAMP_ BIGINT
);

CREATE INDEX INCIDENT_WORKFLOW_INSTANCE_KEY_INDEX ON INCIDENT(WORKFLOW_INSTANCE_KEY_);