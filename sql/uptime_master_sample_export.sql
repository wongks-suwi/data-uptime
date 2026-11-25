-- Uptime Master export · 2026-11 · generated 2026-11-25

-- Uptime Master: SQL schema (ANSI-style; runs on PostgreSQL, SQLite, MySQL 8, SQL Server with minor type changes)
CREATE TABLE machine (
  machine_id         VARCHAR(60)  PRIMARY KEY,
  line               VARCHAR(10),
  machine_type       VARCHAR(20),
  plant              VARCHAR(10),
  machine_name       VARCHAR(120),
  ct_sec             NUMERIC(8,2),
  loading_sec        NUMERIC(8,2) DEFAULT 0,
  efficiency         NUMERIC(5,4),
  alias_downtime     VARCHAR(120),
  alias_uptime_show  VARCHAR(120),
  alias_productivity VARCHAR(120),
  note               VARCHAR(255),
  sort_no            INTEGER
);
CREATE TABLE downtime_cause (
  cause_id INTEGER PRIMARY KEY,
  name_th  VARCHAR(80),
  name_ko  VARCHAR(80),
  name_en  VARCHAR(80)
);
CREATE TABLE setting (
  setting_key   VARCHAR(40) PRIMARY KEY,
  setting_value VARCHAR(40)
);
CREATE TABLE week_def (
  month_start DATE    NOT NULL,
  week_no     INTEGER NOT NULL,
  date_from   DATE    NOT NULL,
  date_to     DATE    NOT NULL,
  PRIMARY KEY (month_start, week_no)
);
CREATE TABLE production_log (
  log_id          VARCHAR(40) PRIMARY KEY,
  work_date       DATE        NOT NULL,
  shift           CHAR(1)     NOT NULL CHECK (shift IN ('D','N')),
  machine_id      VARCHAR(60) NOT NULL REFERENCES machine (machine_id),
  item            VARCHAR(255),
  std_minutes     NUMERIC(8,2) NOT NULL,
  input_qty       INTEGER NOT NULL DEFAULT 0,
  ng_qty          INTEGER NOT NULL DEFAULT 0,
  working_hours   NUMERIC(6,2),
  ct_override_sec NUMERIC(8,2),
  note            VARCHAR(255)
);
CREATE TABLE downtime_log (
  log_id   VARCHAR(40) NOT NULL REFERENCES production_log (log_id),
  cause_id INTEGER     NOT NULL REFERENCES downtime_cause (cause_id),
  minutes  NUMERIC(8,2) NOT NULL,
  PRIMARY KEY (log_id, cause_id)
);
CREATE INDEX ix_production_date    ON production_log (work_date, machine_id);
CREATE INDEX ix_downtime_cause     ON downtime_log (cause_id);

-- ---------- reference data ----------
INSERT INTO downtime_cause VALUES (1, 'เปลี่ยนรุ่น', '품목변경', 'Model change');
INSERT INTO downtime_cause VALUES (2, 'ปรับเครื่อง', '조정', 'Machine adjustment');
INSERT INTO downtime_cause VALUES (3, 'เปลี่ยนแม่พิมพ์ที่เสียหาย', '금형 파손 교환', 'Broken die replacement');
INSERT INTO downtime_cause VALUES (4, 'ซ่อมแม่พิมพ์', '금형수리', 'Die repair');
INSERT INTO downtime_cause VALUES (5, 'เปลี่ยนวัตถุดิบ', '원재료 교환', 'Raw material change');
INSERT INTO downtime_cause VALUES (6, 'รอแม่พิมพ์', '금형 대기', 'Waiting for die');
INSERT INTO downtime_cause VALUES (7, 'รอวัตถุดิบ', '원소재 대기', 'Waiting for material');
INSERT INTO downtime_cause VALUES (8, 'รอพนักงาน', '인원 대기', 'Waiting for operator');
INSERT INTO downtime_cause VALUES (9, 'รอการตรวจสอบ', '검사 대기', 'Waiting for inspection');
INSERT INTO downtime_cause VALUES (10, 'เครื่องจักรเสีย', '설비고장', 'Machine breakdown');
INSERT INTO downtime_cause VALUES (11, 'สลับกะการทำงาน', '공회전', 'Shift change / idle');
INSERT INTO downtime_cause VALUES (12, 'ถ่ายน้ำมันเครื่อง', '오일 교환', 'Oil change');
INSERT INTO downtime_cause VALUES (13, 'ทำความสะอาดเครื่องจักร', '기계 청소 필요 시', 'Machine cleaning');
INSERT INTO downtime_cause VALUES (14, 'หยุดทำความสะอาด (5ส)', '청소(정지시)', 'Cleaning stop (5S)');
INSERT INTO downtime_cause VALUES (15, 'ของเสีย', '불량', 'Defect / scrap');
INSERT INTO downtime_cause VALUES (16, 'อื่น ๆ', '기타', 'Other');
INSERT INTO setting VALUES ('op_hours', '10.5');
INSERT INTO setting VALUES ('target', '0.75');
INSERT INTO setting VALUES ('efficiency', '0.7');
INSERT INTO setting VALUES ('base', 'std');
INSERT INTO setting VALUES ('month', '2026-11');
INSERT INTO week_def VALUES ('2026-11-01', 1, '2026-11-01', '2026-11-03');
INSERT INTO week_def VALUES ('2026-11-01', 2, '2026-11-04', '2026-11-10');
INSERT INTO week_def VALUES ('2026-11-01', 3, '2026-11-11', '2026-11-17');
INSERT INTO week_def VALUES ('2026-11-01', 4, '2026-11-18', '2026-11-24');
INSERT INTO week_def VALUES ('2026-11-01', 5, '2026-11-25', '2026-11-30');
INSERT INTO machine VALUES ('CL-118', 'CNC', 'CNC', 'F3', 'CNC-10-1 (#118)', 39, 0, NULL, '118 CNC 10 -1', 'CNC-10-1 (#118)', 'DH-CL-118', NULL, 1);
INSERT INTO machine VALUES ('CL-119', 'CNC', 'CNC', 'F3', 'CNC-10-2 (#119)', 39, 0, NULL, '119 CNC 10 -2', 'CNC-10-2 (#119)', 'DH-CL-119', NULL, 2);
INSERT INTO machine VALUES ('CL-152', 'CNC', 'CNC', 'F3', 'CNC-20-1 (#152)', 90, 0, NULL, '152 CNC 20-1', 'CNC-20-1 (#152)', 'DH-CL-152', NULL, 3);
INSERT INTO machine VALUES ('CL-153', 'CNC', 'CNC', 'F3', 'CNC-20-2 (#153)', 97, 0, NULL, '153 CNC 20-2', 'CNC-20-2 (#153)', 'DH-CL-153', NULL, 4);
INSERT INTO machine VALUES ('CL-171', 'CNC', 'CNC', 'F3', 'CNC-20-3 Robot (#171)', 98, 0, NULL, 'CL - 171 CNC 20-3', 'CNC-20-3 Robot (#171)', 'DH-CL-171', NULL, 5);
INSERT INTO machine VALUES ('CL-170', 'CNC', 'CNC', 'F3', 'CNC-20-4 Robot (#170)', 101, 0, NULL, 'CL - 170 CNC 20-4', 'CNC-20-4 Robot (#170)', 'DH-CL-170', NULL, 6);
INSERT INTO machine VALUES ('CL-178', 'CNC', 'CNC', 'F3', 'CNC-30-1 Robot (#178)', 50, 0, NULL, '178 CNC 30-1', 'CNC-30-1 Robot (#178)', 'DH-CL-178', NULL, 7);
INSERT INTO machine VALUES ('SHY-17', 'HYD', 'Multi-HYD', 'F1', 'DHP-25-24 / SHY-17', 18, 0, NULL, 'DHP-25-24 SHY-17', NULL, 'DHP-25-24 No.17', NULL, 8);
INSERT INTO machine VALUES ('SHY-18', 'HYD', 'Multi-HYD', 'F1', 'DHP-25-25 / SHY-18', 18, 0, NULL, 'DHP-25-25 SHY-18', NULL, 'DHP-25-25 No.18', NULL, 9);

-- ---------- transactions ----------
INSERT INTO production_log VALUES ('sCL118D16', '2026-11-16', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 545, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N16', '2026-11-16', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 562, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D16', '2026-11-16', 'D', 'CL-119', NULL, 630, 543, 4, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N16', '2026-11-16', 'N', 'CL-119', NULL, 530, 425, 1, 6.33, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D16', '2026-11-16', 'D', 'CL-152', NULL, 510, 200, 3, 4, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N16', '2026-11-16', 'N', 'CL-152', NULL, 610, 236, 6, 8.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D16', '2026-11-16', 'D', 'CL-153', NULL, 510, 205, 3, 4, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N16', '2026-11-16', 'N', 'CL-153', NULL, 630, 327, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D16', '2026-11-16', 'D', 'CL-178', NULL, 630, 603, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N16', '2026-11-16', 'N', 'CL-178', NULL, 530, 462, 3, 6.67, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D17', '2026-11-17', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 451, 7, 7.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N17', '2026-11-17', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 544, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D17', '2026-11-17', 'D', 'CL-119', NULL, 610, 288, 2, 5.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N17', '2026-11-17', 'N', 'CL-119', NULL, 610, 156, 13, 6, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D17', '2026-11-17', 'D', 'CL-152', NULL, 610, 320, 1, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N17', '2026-11-17', 'N', 'CL-152', NULL, 630, 274, 1, 9.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D17', '2026-11-17', 'D', 'CL-153', NULL, 610, 321, 1, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N17', '2026-11-17', 'N', 'CL-153', NULL, 630, 270, 0, 9.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N17', '2026-11-17', 'N', 'CL-170', NULL, 630, 106, 3, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N17', '2026-11-17', 'N', 'CL-171', NULL, 630, 106, 3, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N17', '2026-11-17', 'N', 'CL-178', NULL, 630, 206, 14, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D18', '2026-11-18', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 530, 510, 11, 8.67, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N18', '2026-11-18', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 608, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D18', '2026-11-18', 'D', 'CL-119', NULL, 630, 601, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N18', '2026-11-18', 'N', 'CL-119', NULL, 630, 607, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D18', '2026-11-18', 'D', 'CL-152', NULL, 510, 237, 2, 7.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N18', '2026-11-18', 'N', 'CL-152', NULL, 530, 221, 5, 7.83, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D18', '2026-11-18', 'D', 'CL-153', NULL, 510, 237, 3, 7.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N18', '2026-11-18', 'N', 'CL-153', NULL, 530, 221, 5, 7.83, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D18', '2026-11-18', 'D', 'CL-170', NULL, 610, 247, 6, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N18', '2026-11-18', 'N', 'CL-170', NULL, 630, 163, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D18', '2026-11-18', 'D', 'CL-171', NULL, 610, 257, 5, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N18', '2026-11-18', 'N', 'CL-171', NULL, 630, 163, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D18', '2026-11-18', 'D', 'CL-178', NULL, 610, 493, 37, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N18', '2026-11-18', 'N', 'CL-178', NULL, 630, 321, 9, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D19', '2026-11-19', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 602, 8, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N19', '2026-11-19', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 530, 554, 1, 8.83, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D19', '2026-11-19', 'D', 'CL-119', NULL, 630, 601, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N19', '2026-11-19', 'N', 'CL-119', NULL, 530, 555, 2, 8.83, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D19', '2026-11-19', 'D', 'CL-152', NULL, 610, 250, 5, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N19', '2026-11-19', 'N', 'CL-152', NULL, 630, 332, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D19', '2026-11-19', 'D', 'CL-153', NULL, 610, 203, 11, 8, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N19', '2026-11-19', 'N', 'CL-153', NULL, 630, 332, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D19', '2026-11-19', 'D', 'CL-170', NULL, 610, 250, 1, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N19', '2026-11-19', 'N', 'CL-170', NULL, 630, 217, 4, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D19', '2026-11-19', 'D', 'CL-171', NULL, 610, 272, 1, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N19', '2026-11-19', 'N', 'CL-171', NULL, 630, 217, 4, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D19', '2026-11-19', 'D', 'CL-178', NULL, 610, 535, 11, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N19', '2026-11-19', 'N', 'CL-178', NULL, 630, 426, 15, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D20', '2026-11-20', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 700, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N20', '2026-11-20', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 530, 192, 0, 8.8, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D20', '2026-11-20', 'D', 'CL-119', NULL, 630, 675, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N20', '2026-11-20', 'N', 'CL-119', NULL, 530, 192, 0, 8.83, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D20', '2026-11-20', 'D', 'CL-152', NULL, 610, 280, 10, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N20', '2026-11-20', 'N', 'CL-152', NULL, 610, 241, 5, 8.67, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D20', '2026-11-20', 'D', 'CL-153', NULL, 610, 271, 10, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N20', '2026-11-20', 'N', 'CL-153', NULL, 610, 241, 4, 7.33, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D20', '2026-11-20', 'D', 'CL-170', NULL, 510, 201, 2, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N20', '2026-11-20', 'N', 'CL-170', NULL, 630, 182, 5, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D20', '2026-11-20', 'D', 'CL-171', NULL, 510, 212, 4, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N20', '2026-11-20', 'N', 'CL-171', NULL, 630, 198, 5, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D20', '2026-11-20', 'D', 'CL-178', NULL, 510, 407, 6, 8.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N20', '2026-11-20', 'N', 'CL-178', NULL, 630, 370, 10, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY17D20', '2026-11-20', 'D', 'SHY-17', 'MANDO', 630, 1630, 3, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY17N20', '2026-11-20', 'N', 'SHY-17', 'MANDO', 530, 1714, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY18D20', '2026-11-20', 'D', 'SHY-18', 'MANDO', 630, 1322, 5, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY18N20', '2026-11-20', 'N', 'SHY-18', 'MANDO', 630, 1442, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D21', '2026-11-21', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 715, 14, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N21', '2026-11-21', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 720, 4, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D21', '2026-11-21', 'D', 'CL-119', NULL, 630, 705, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N21', '2026-11-21', 'N', 'CL-119', NULL, 630, 733, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D21', '2026-11-21', 'D', 'CL-152', NULL, 610, 294, 4, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N21', '2026-11-21', 'N', 'CL-152', NULL, 630, 326, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D21', '2026-11-21', 'D', 'CL-153', NULL, 610, 292, 5, 10.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N21', '2026-11-21', 'N', 'CL-153', NULL, 630, 325, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D21', '2026-11-21', 'D', 'CL-170', NULL, 610, 221, 1, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N21', '2026-11-21', 'N', 'CL-170', NULL, 630, 186, 8, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D21', '2026-11-21', 'D', 'CL-171', NULL, 610, 226, 0, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N21', '2026-11-21', 'N', 'CL-171', NULL, 630, 195, 7, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D21', '2026-11-21', 'D', 'CL-178', NULL, 610, 446, 14, 9.17, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N21', '2026-11-21', 'N', 'CL-178', NULL, 630, 367, 9, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY17D21', '2026-11-21', 'D', 'SHY-17', 'MANDO', 630, 1630, 3, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY17N21', '2026-11-21', 'N', 'SHY-17', 'MANDO', 530, 1714, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY18D21', '2026-11-21', 'D', 'SHY-18', 'MANDO', 630, 1322, 5, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sSHY18N21', '2026-11-21', 'N', 'SHY-18', 'MANDO', 630, 1442, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D22', '2026-11-22', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 706, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N22', '2026-11-22', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 709, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D22', '2026-11-22', 'D', 'CL-119', NULL, 630, 703, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N22', '2026-11-22', 'N', 'CL-119', NULL, 630, 717, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D22', '2026-11-22', 'D', 'CL-152', NULL, 610, 305, 5, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N22', '2026-11-22', 'N', 'CL-152', NULL, 630, 325, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D22', '2026-11-22', 'D', 'CL-153', NULL, 610, 305, 4, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N22', '2026-11-22', 'N', 'CL-153', NULL, 630, 325, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D22', '2026-11-22', 'D', 'CL-170', NULL, 610, 240, 4, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N22', '2026-11-22', 'N', 'CL-170', NULL, 630, 238, 7, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D22', '2026-11-22', 'D', 'CL-171', NULL, 610, 252, 5, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N22', '2026-11-22', 'N', 'CL-171', NULL, 630, 263, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D22', '2026-11-22', 'D', 'CL-178', NULL, 610, 483, 3, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N22', '2026-11-22', 'N', 'CL-178', NULL, 630, 489, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D23', '2026-11-23', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 702, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N23', '2026-11-23', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 648, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D23', '2026-11-23', 'D', 'CL-119', NULL, 630, 700, 0, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N23', '2026-11-23', 'N', 'CL-119', NULL, 630, 662, 0, 11.33, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D23', '2026-11-23', 'D', 'CL-152', NULL, 610, 321, 5, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N23', '2026-11-23', 'N', 'CL-152', NULL, 630, 337, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D23', '2026-11-23', 'D', 'CL-153', NULL, 610, 321, 2, 10.2, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N23', '2026-11-23', 'N', 'CL-153', NULL, 630, 337, 1, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D23', '2026-11-23', 'D', 'CL-170', NULL, 610, 187, 6, 7, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N23', '2026-11-23', 'N', 'CL-170', NULL, 630, 235, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D23', '2026-11-23', 'D', 'CL-171', NULL, 610, 191, 3, 7, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N23', '2026-11-23', 'N', 'CL-171', NULL, 630, 254, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D23', '2026-11-23', 'D', 'CL-178', NULL, 610, 369, 9, 7, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N23', '2026-11-23', 'N', 'CL-178', NULL, 630, 485, 2, 10.5, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118D24', '2026-11-24', 'D', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 708, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL118N24', '2026-11-24', 'N', 'CL-118', 'NX4 KA ESCL; HCYB TELES 2900; BN7i; HCYB TELES MSCL (2800&TMA)', 630, 732, 0, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119D24', '2026-11-24', 'D', 'CL-119', NULL, 630, 709, 1, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL119N24', '2026-11-24', 'N', 'CL-119', NULL, 630, 732, 1, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152D24', '2026-11-24', 'D', 'CL-152', NULL, 610, 324, 4, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL152N24', '2026-11-24', 'N', 'CL-152', NULL, 630, 335, 3, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153D24', '2026-11-24', 'D', 'CL-153', NULL, 610, 325, 5, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL153N24', '2026-11-24', 'N', 'CL-153', NULL, 610, 324, 3, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170D24', '2026-11-24', 'D', 'CL-170', NULL, 510, 214, 6, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL170N24', '2026-11-24', 'N', 'CL-170', NULL, 630, 210, 7, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171D24', '2026-11-24', 'D', 'CL-171', NULL, 510, 222, 3, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL171N24', '2026-11-24', 'N', 'CL-171', NULL, 630, 221, 7, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178D24', '2026-11-24', 'D', 'CL-178', NULL, 510, 426, 9, NULL, NULL, NULL);
INSERT INTO production_log VALUES ('sCL178N24', '2026-11-24', 'N', 'CL-178', NULL, 630, 417, 5, NULL, NULL, NULL);
INSERT INTO downtime_log VALUES ('sCL118D16', 2, 25);
INSERT INTO downtime_log VALUES ('sCL118D16', 3, 25);
INSERT INTO downtime_log VALUES ('sCL118D16', 9, 25);
INSERT INTO downtime_log VALUES ('sCL118D16', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N16', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N16', 3, 15);
INSERT INTO downtime_log VALUES ('sCL118N16', 9, 15);
INSERT INTO downtime_log VALUES ('sCL118N16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D16', 2, 25);
INSERT INTO downtime_log VALUES ('sCL119D16', 3, 25);
INSERT INTO downtime_log VALUES ('sCL119D16', 9, 25);
INSERT INTO downtime_log VALUES ('sCL119D16', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N16', 2, 170);
INSERT INTO downtime_log VALUES ('sCL119N16', 3, 20);
INSERT INTO downtime_log VALUES ('sCL119N16', 9, 10);
INSERT INTO downtime_log VALUES ('sCL119N16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D16', 2, 22);
INSERT INTO downtime_log VALUES ('sCL152D16', 3, 15);
INSERT INTO downtime_log VALUES ('sCL152D16', 9, 195);
INSERT INTO downtime_log VALUES ('sCL152D16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N16', 2, 60);
INSERT INTO downtime_log VALUES ('sCL152N16', 3, 90);
INSERT INTO downtime_log VALUES ('sCL152N16', 9, 70);
INSERT INTO downtime_log VALUES ('sCL152N16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D16', 2, 20);
INSERT INTO downtime_log VALUES ('sCL153D16', 3, 20);
INSERT INTO downtime_log VALUES ('sCL153D16', 9, 205);
INSERT INTO downtime_log VALUES ('sCL153D16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N16', 2, 40);
INSERT INTO downtime_log VALUES ('sCL153N16', 3, 55);
INSERT INTO downtime_log VALUES ('sCL153N16', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153N16', 14, 15);
INSERT INTO downtime_log VALUES ('sCL178D16', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178D16', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178D16', 9, 30);
INSERT INTO downtime_log VALUES ('sCL178D16', 14, 10);
INSERT INTO downtime_log VALUES ('sCL178N16', 2, 25);
INSERT INTO downtime_log VALUES ('sCL178N16', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178N16', 9, 25);
INSERT INTO downtime_log VALUES ('sCL178N16', 14, 20);
INSERT INTO downtime_log VALUES ('sCL118D17', 2, 35);
INSERT INTO downtime_log VALUES ('sCL118D17', 3, 30);
INSERT INTO downtime_log VALUES ('sCL118D17', 9, 40);
INSERT INTO downtime_log VALUES ('sCL118D17', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118D17', 16, 120);
INSERT INTO downtime_log VALUES ('sCL118N17', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N17', 3, 20);
INSERT INTO downtime_log VALUES ('sCL118N17', 9, 10);
INSERT INTO downtime_log VALUES ('sCL118N17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D17', 1, 180);
INSERT INTO downtime_log VALUES ('sCL119D17', 2, 40);
INSERT INTO downtime_log VALUES ('sCL119D17', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119D17', 4, 100);
INSERT INTO downtime_log VALUES ('sCL119D17', 9, 40);
INSERT INTO downtime_log VALUES ('sCL119D17', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N17', 2, 340);
INSERT INTO downtime_log VALUES ('sCL119N17', 9, 40);
INSERT INTO downtime_log VALUES ('sCL119N17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D17', 2, 30);
INSERT INTO downtime_log VALUES ('sCL152D17', 3, 35);
INSERT INTO downtime_log VALUES ('sCL152D17', 9, 35);
INSERT INTO downtime_log VALUES ('sCL152D17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N17', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152N17', 3, 30);
INSERT INTO downtime_log VALUES ('sCL152N17', 7, 90);
INSERT INTO downtime_log VALUES ('sCL152N17', 9, 30);
INSERT INTO downtime_log VALUES ('sCL152N17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D17', 2, 30);
INSERT INTO downtime_log VALUES ('sCL153D17', 3, 35);
INSERT INTO downtime_log VALUES ('sCL153D17', 9, 35);
INSERT INTO downtime_log VALUES ('sCL153D17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N17', 2, 60);
INSERT INTO downtime_log VALUES ('sCL153N17', 3, 40);
INSERT INTO downtime_log VALUES ('sCL153N17', 7, 90);
INSERT INTO downtime_log VALUES ('sCL153N17', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153N17', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170N17', 1, 120);
INSERT INTO downtime_log VALUES ('sCL170N17', 2, 20);
INSERT INTO downtime_log VALUES ('sCL170N17', 3, 15);
INSERT INTO downtime_log VALUES ('sCL170N17', 9, 25);
INSERT INTO downtime_log VALUES ('sCL170N17', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171N17', 1, 120);
INSERT INTO downtime_log VALUES ('sCL171N17', 2, 20);
INSERT INTO downtime_log VALUES ('sCL171N17', 3, 10);
INSERT INTO downtime_log VALUES ('sCL171N17', 9, 20);
INSERT INTO downtime_log VALUES ('sCL171N17', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178N17', 1, 120);
INSERT INTO downtime_log VALUES ('sCL178N17', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178N17', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178N17', 9, 20);
INSERT INTO downtime_log VALUES ('sCL178N17', 14, 30);
INSERT INTO downtime_log VALUES ('sCL118D18', 1, 60);
INSERT INTO downtime_log VALUES ('sCL118D18', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118D18', 3, 20);
INSERT INTO downtime_log VALUES ('sCL118D18', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118D18', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N18', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N18', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118N18', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118N18', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D18', 2, 35);
INSERT INTO downtime_log VALUES ('sCL119D18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL119D18', 9, 30);
INSERT INTO downtime_log VALUES ('sCL119D18', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119D18', 16, 40);
INSERT INTO downtime_log VALUES ('sCL119N18', 2, 20);
INSERT INTO downtime_log VALUES ('sCL119N18', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119N18', 9, 20);
INSERT INTO downtime_log VALUES ('sCL119N18', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D18', 1, 75);
INSERT INTO downtime_log VALUES ('sCL152D18', 2, 20);
INSERT INTO downtime_log VALUES ('sCL152D18', 3, 20);
INSERT INTO downtime_log VALUES ('sCL152D18', 9, 40);
INSERT INTO downtime_log VALUES ('sCL152D18', 14, 40);
INSERT INTO downtime_log VALUES ('sCL152N18', 2, 45);
INSERT INTO downtime_log VALUES ('sCL152N18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL152N18', 7, 80);
INSERT INTO downtime_log VALUES ('sCL152N18', 9, 45);
INSERT INTO downtime_log VALUES ('sCL152N18', 14, 15);
INSERT INTO downtime_log VALUES ('sCL153D18', 1, 85);
INSERT INTO downtime_log VALUES ('sCL153D18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL153D18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL153D18', 9, 25);
INSERT INTO downtime_log VALUES ('sCL153D18', 14, 40);
INSERT INTO downtime_log VALUES ('sCL153N18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL153N18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL153N18', 7, 80);
INSERT INTO downtime_log VALUES ('sCL153N18', 9, 60);
INSERT INTO downtime_log VALUES ('sCL153N18', 14, 15);
INSERT INTO downtime_log VALUES ('sCL170D18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL170D18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL170D18', 9, 30);
INSERT INTO downtime_log VALUES ('sCL170D18', 14, 40);
INSERT INTO downtime_log VALUES ('sCL170D18', 16, 40);
INSERT INTO downtime_log VALUES ('sCL170N18', 2, 25);
INSERT INTO downtime_log VALUES ('sCL170N18', 3, 20);
INSERT INTO downtime_log VALUES ('sCL170N18', 9, 25);
INSERT INTO downtime_log VALUES ('sCL170N18', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171D18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL171D18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL171D18', 9, 30);
INSERT INTO downtime_log VALUES ('sCL171D18', 14, 40);
INSERT INTO downtime_log VALUES ('sCL171D18', 16, 40);
INSERT INTO downtime_log VALUES ('sCL171N18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL171N18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL171N18', 9, 30);
INSERT INTO downtime_log VALUES ('sCL171N18', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178D18', 2, 30);
INSERT INTO downtime_log VALUES ('sCL178D18', 3, 30);
INSERT INTO downtime_log VALUES ('sCL178D18', 9, 30);
INSERT INTO downtime_log VALUES ('sCL178D18', 14, 40);
INSERT INTO downtime_log VALUES ('sCL178D18', 16, 50);
INSERT INTO downtime_log VALUES ('sCL178N18', 2, 25);
INSERT INTO downtime_log VALUES ('sCL178N18', 3, 20);
INSERT INTO downtime_log VALUES ('sCL178N18', 9, 25);
INSERT INTO downtime_log VALUES ('sCL178N18', 10, 30);
INSERT INTO downtime_log VALUES ('sCL178N18', 14, 30);
INSERT INTO downtime_log VALUES ('sCL118D19', 2, 25);
INSERT INTO downtime_log VALUES ('sCL118D19', 3, 20);
INSERT INTO downtime_log VALUES ('sCL118D19', 9, 30);
INSERT INTO downtime_log VALUES ('sCL118D19', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N19', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N19', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118N19', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118N19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D19', 2, 15);
INSERT INTO downtime_log VALUES ('sCL119D19', 3, 15);
INSERT INTO downtime_log VALUES ('sCL119D19', 9, 20);
INSERT INTO downtime_log VALUES ('sCL119D19', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N19', 2, 20);
INSERT INTO downtime_log VALUES ('sCL119N19', 3, 20);
INSERT INTO downtime_log VALUES ('sCL119N19', 9, 10);
INSERT INTO downtime_log VALUES ('sCL119N19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D19', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152D19', 3, 30);
INSERT INTO downtime_log VALUES ('sCL152D19', 9, 50);
INSERT INTO downtime_log VALUES ('sCL152D19', 14, 30);
INSERT INTO downtime_log VALUES ('sCL152D19', 16, 40);
INSERT INTO downtime_log VALUES ('sCL152N19', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152N19', 3, 20);
INSERT INTO downtime_log VALUES ('sCL152N19', 9, 40);
INSERT INTO downtime_log VALUES ('sCL152N19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D19', 2, 85);
INSERT INTO downtime_log VALUES ('sCL153D19', 3, 40);
INSERT INTO downtime_log VALUES ('sCL153D19', 4, 85);
INSERT INTO downtime_log VALUES ('sCL153D19', 9, 50);
INSERT INTO downtime_log VALUES ('sCL153D19', 10, 40);
INSERT INTO downtime_log VALUES ('sCL153D19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N19', 2, 35);
INSERT INTO downtime_log VALUES ('sCL153N19', 3, 25);
INSERT INTO downtime_log VALUES ('sCL153N19', 9, 30);
INSERT INTO downtime_log VALUES ('sCL153N19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D19', 2, 35);
INSERT INTO downtime_log VALUES ('sCL170D19', 3, 30);
INSERT INTO downtime_log VALUES ('sCL170D19', 9, 35);
INSERT INTO downtime_log VALUES ('sCL170D19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D19', 16, 20);
INSERT INTO downtime_log VALUES ('sCL170N19', 2, 20);
INSERT INTO downtime_log VALUES ('sCL170N19', 3, 20);
INSERT INTO downtime_log VALUES ('sCL170N19', 9, 20);
INSERT INTO downtime_log VALUES ('sCL170N19', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171D19', 2, 30);
INSERT INTO downtime_log VALUES ('sCL171D19', 3, 20);
INSERT INTO downtime_log VALUES ('sCL171D19', 9, 30);
INSERT INTO downtime_log VALUES ('sCL171D19', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171N19', 2, 25);
INSERT INTO downtime_log VALUES ('sCL171N19', 3, 30);
INSERT INTO downtime_log VALUES ('sCL171N19', 9, 25);
INSERT INTO downtime_log VALUES ('sCL171N19', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178D19', 2, 40);
INSERT INTO downtime_log VALUES ('sCL178D19', 3, 15);
INSERT INTO downtime_log VALUES ('sCL178D19', 9, 45);
INSERT INTO downtime_log VALUES ('sCL178D19', 14, 15);
INSERT INTO downtime_log VALUES ('sCL178D19', 16, 25);
INSERT INTO downtime_log VALUES ('sCL178N19', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178N19', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178N19', 9, 20);
INSERT INTO downtime_log VALUES ('sCL178N19', 14, 30);
INSERT INTO downtime_log VALUES ('sCL118D20', 1, 20);
INSERT INTO downtime_log VALUES ('sCL118D20', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118D20', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118D20', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118D20', 10, 20);
INSERT INTO downtime_log VALUES ('sCL118D20', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N20', 2, 10);
INSERT INTO downtime_log VALUES ('sCL118N20', 9, 10);
INSERT INTO downtime_log VALUES ('sCL118N20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D20', 2, 25);
INSERT INTO downtime_log VALUES ('sCL119D20', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119D20', 9, 25);
INSERT INTO downtime_log VALUES ('sCL119D20', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N20', 2, 10);
INSERT INTO downtime_log VALUES ('sCL119N20', 9, 10);
INSERT INTO downtime_log VALUES ('sCL119N20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D20', 2, 94);
INSERT INTO downtime_log VALUES ('sCL152D20', 3, 28);
INSERT INTO downtime_log VALUES ('sCL152D20', 9, 55);
INSERT INTO downtime_log VALUES ('sCL152D20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N20', 2, 32);
INSERT INTO downtime_log VALUES ('sCL152N20', 3, 25);
INSERT INTO downtime_log VALUES ('sCL152N20', 9, 45);
INSERT INTO downtime_log VALUES ('sCL152N20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D20', 2, 87);
INSERT INTO downtime_log VALUES ('sCL153D20', 3, 28);
INSERT INTO downtime_log VALUES ('sCL153D20', 9, 55);
INSERT INTO downtime_log VALUES ('sCL153D20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N20', 2, 50);
INSERT INTO downtime_log VALUES ('sCL153N20', 3, 15);
INSERT INTO downtime_log VALUES ('sCL153N20', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153N20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D20', 2, 20);
INSERT INTO downtime_log VALUES ('sCL170D20', 3, 5);
INSERT INTO downtime_log VALUES ('sCL170D20', 9, 35);
INSERT INTO downtime_log VALUES ('sCL170D20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D20', 16, 30);
INSERT INTO downtime_log VALUES ('sCL170N20', 2, 20);
INSERT INTO downtime_log VALUES ('sCL170N20', 3, 10);
INSERT INTO downtime_log VALUES ('sCL170N20', 9, 20);
INSERT INTO downtime_log VALUES ('sCL170N20', 14, 30);
INSERT INTO downtime_log VALUES ('sCL170N20', 16, 40);
INSERT INTO downtime_log VALUES ('sCL171D20', 2, 25);
INSERT INTO downtime_log VALUES ('sCL171D20', 3, 5);
INSERT INTO downtime_log VALUES ('sCL171D20', 9, 35);
INSERT INTO downtime_log VALUES ('sCL171D20', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171D20', 16, 30);
INSERT INTO downtime_log VALUES ('sCL171N20', 2, 20);
INSERT INTO downtime_log VALUES ('sCL171N20', 3, 10);
INSERT INTO downtime_log VALUES ('sCL171N20', 9, 20);
INSERT INTO downtime_log VALUES ('sCL171N20', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171N20', 16, 40);
INSERT INTO downtime_log VALUES ('sCL178D20', 2, 35);
INSERT INTO downtime_log VALUES ('sCL178D20', 3, 15);
INSERT INTO downtime_log VALUES ('sCL178D20', 9, 50);
INSERT INTO downtime_log VALUES ('sCL178D20', 14, 20);
INSERT INTO downtime_log VALUES ('sCL178D20', 16, 30);
INSERT INTO downtime_log VALUES ('sCL178N20', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178N20', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178N20', 9, 20);
INSERT INTO downtime_log VALUES ('sCL178N20', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178N20', 16, 40);
INSERT INTO downtime_log VALUES ('sSHY17D20', 9, 30);
INSERT INTO downtime_log VALUES ('sSHY17N20', 1, 200);
INSERT INTO downtime_log VALUES ('sSHY17N20', 9, 10);
INSERT INTO downtime_log VALUES ('sSHY18D20', 9, 30);
INSERT INTO downtime_log VALUES ('sSHY18N20', 9, 10);
INSERT INTO downtime_log VALUES ('sCL118D21', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118D21', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118D21', 9, 25);
INSERT INTO downtime_log VALUES ('sCL118D21', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N21', 2, 22);
INSERT INTO downtime_log VALUES ('sCL118N21', 3, 8);
INSERT INTO downtime_log VALUES ('sCL118N21', 9, 30);
INSERT INTO downtime_log VALUES ('sCL118N21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D21', 2, 20);
INSERT INTO downtime_log VALUES ('sCL119D21', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119D21', 9, 25);
INSERT INTO downtime_log VALUES ('sCL119D21', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N21', 2, 42);
INSERT INTO downtime_log VALUES ('sCL119N21', 3, 8);
INSERT INTO downtime_log VALUES ('sCL119N21', 9, 30);
INSERT INTO downtime_log VALUES ('sCL119N21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D21', 2, 45);
INSERT INTO downtime_log VALUES ('sCL152D21', 3, 12);
INSERT INTO downtime_log VALUES ('sCL152D21', 9, 45);
INSERT INTO downtime_log VALUES ('sCL152D21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N21', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152N21', 3, 25);
INSERT INTO downtime_log VALUES ('sCL152N21', 9, 45);
INSERT INTO downtime_log VALUES ('sCL152N21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D21', 2, 53);
INSERT INTO downtime_log VALUES ('sCL153D21', 3, 27);
INSERT INTO downtime_log VALUES ('sCL153D21', 9, 65);
INSERT INTO downtime_log VALUES ('sCL153D21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N21', 2, 60);
INSERT INTO downtime_log VALUES ('sCL153N21', 3, 25);
INSERT INTO downtime_log VALUES ('sCL153N21', 9, 55);
INSERT INTO downtime_log VALUES ('sCL153N21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D21', 2, 26);
INSERT INTO downtime_log VALUES ('sCL170D21', 3, 9);
INSERT INTO downtime_log VALUES ('sCL170D21', 9, 45);
INSERT INTO downtime_log VALUES ('sCL170D21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D21', 16, 30);
INSERT INTO downtime_log VALUES ('sCL170N21', 2, 30);
INSERT INTO downtime_log VALUES ('sCL170N21', 3, 30);
INSERT INTO downtime_log VALUES ('sCL170N21', 9, 30);
INSERT INTO downtime_log VALUES ('sCL170N21', 14, 30);
INSERT INTO downtime_log VALUES ('sCL170N21', 16, 10);
INSERT INTO downtime_log VALUES ('sCL171D21', 2, 24);
INSERT INTO downtime_log VALUES ('sCL171D21', 3, 6);
INSERT INTO downtime_log VALUES ('sCL171D21', 9, 40);
INSERT INTO downtime_log VALUES ('sCL171D21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171D21', 16, 30);
INSERT INTO downtime_log VALUES ('sCL171N21', 2, 80);
INSERT INTO downtime_log VALUES ('sCL171N21', 3, 30);
INSERT INTO downtime_log VALUES ('sCL171N21', 5, 5);
INSERT INTO downtime_log VALUES ('sCL171N21', 9, 25);
INSERT INTO downtime_log VALUES ('sCL171N21', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171N21', 16, 10);
INSERT INTO downtime_log VALUES ('sCL178D21', 2, 24);
INSERT INTO downtime_log VALUES ('sCL178D21', 3, 6);
INSERT INTO downtime_log VALUES ('sCL178D21', 9, 40);
INSERT INTO downtime_log VALUES ('sCL178D21', 14, 10);
INSERT INTO downtime_log VALUES ('sCL178D21', 16, 30);
INSERT INTO downtime_log VALUES ('sCL178N21', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178N21', 3, 10);
INSERT INTO downtime_log VALUES ('sCL178N21', 9, 20);
INSERT INTO downtime_log VALUES ('sCL178N21', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178N21', 16, 10);
INSERT INTO downtime_log VALUES ('sSHY17D21', 9, 30);
INSERT INTO downtime_log VALUES ('sSHY17N21', 1, 200);
INSERT INTO downtime_log VALUES ('sSHY17N21', 9, 10);
INSERT INTO downtime_log VALUES ('sSHY18D21', 9, 30);
INSERT INTO downtime_log VALUES ('sSHY18N21', 9, 10);
INSERT INTO downtime_log VALUES ('sCL118D22', 2, 21);
INSERT INTO downtime_log VALUES ('sCL118D22', 3, 9);
INSERT INTO downtime_log VALUES ('sCL118D22', 9, 25);
INSERT INTO downtime_log VALUES ('sCL118D22', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118N22', 2, 24);
INSERT INTO downtime_log VALUES ('sCL118N22', 3, 9);
INSERT INTO downtime_log VALUES ('sCL118N22', 9, 35);
INSERT INTO downtime_log VALUES ('sCL118N22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D22', 2, 21);
INSERT INTO downtime_log VALUES ('sCL119D22', 3, 9);
INSERT INTO downtime_log VALUES ('sCL119D22', 9, 25);
INSERT INTO downtime_log VALUES ('sCL119D22', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N22', 2, 24);
INSERT INTO downtime_log VALUES ('sCL119N22', 3, 9);
INSERT INTO downtime_log VALUES ('sCL119N22', 9, 35);
INSERT INTO downtime_log VALUES ('sCL119N22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D22', 2, 34);
INSERT INTO downtime_log VALUES ('sCL152D22', 3, 16);
INSERT INTO downtime_log VALUES ('sCL152D22', 9, 40);
INSERT INTO downtime_log VALUES ('sCL152D22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N22', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152N22', 3, 25);
INSERT INTO downtime_log VALUES ('sCL152N22', 9, 45);
INSERT INTO downtime_log VALUES ('sCL152N22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D22', 2, 33);
INSERT INTO downtime_log VALUES ('sCL153D22', 3, 17);
INSERT INTO downtime_log VALUES ('sCL153D22', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153D22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N22', 2, 40);
INSERT INTO downtime_log VALUES ('sCL153N22', 3, 25);
INSERT INTO downtime_log VALUES ('sCL153N22', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153N22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D22', 2, 22);
INSERT INTO downtime_log VALUES ('sCL170D22', 3, 3);
INSERT INTO downtime_log VALUES ('sCL170D22', 9, 35);
INSERT INTO downtime_log VALUES ('sCL170D22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D22', 16, 60);
INSERT INTO downtime_log VALUES ('sCL170N22', 2, 20);
INSERT INTO downtime_log VALUES ('sCL170N22', 3, 20);
INSERT INTO downtime_log VALUES ('sCL170N22', 9, 20);
INSERT INTO downtime_log VALUES ('sCL170N22', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171D22', 2, 29);
INSERT INTO downtime_log VALUES ('sCL171D22', 3, 9);
INSERT INTO downtime_log VALUES ('sCL171D22', 9, 50);
INSERT INTO downtime_log VALUES ('sCL171D22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171D22', 16, 50);
INSERT INTO downtime_log VALUES ('sCL171N22', 2, 20);
INSERT INTO downtime_log VALUES ('sCL171N22', 3, 20);
INSERT INTO downtime_log VALUES ('sCL171N22', 9, 25);
INSERT INTO downtime_log VALUES ('sCL171N22', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178D22', 2, 25);
INSERT INTO downtime_log VALUES ('sCL178D22', 3, 5);
INSERT INTO downtime_log VALUES ('sCL178D22', 9, 40);
INSERT INTO downtime_log VALUES ('sCL178D22', 14, 10);
INSERT INTO downtime_log VALUES ('sCL178D22', 16, 60);
INSERT INTO downtime_log VALUES ('sCL178N22', 2, 20);
INSERT INTO downtime_log VALUES ('sCL178N22', 3, 20);
INSERT INTO downtime_log VALUES ('sCL178N22', 9, 20);
INSERT INTO downtime_log VALUES ('sCL178N22', 14, 30);
INSERT INTO downtime_log VALUES ('sCL118D23', 2, 17);
INSERT INTO downtime_log VALUES ('sCL118D23', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118D23', 9, 25);
INSERT INTO downtime_log VALUES ('sCL118D23', 14, 15);
INSERT INTO downtime_log VALUES ('sCL118D23', 16, 30);
INSERT INTO downtime_log VALUES ('sCL118N23', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N23', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118N23', 7, 20);
INSERT INTO downtime_log VALUES ('sCL118N23', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118N23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D23', 2, 17);
INSERT INTO downtime_log VALUES ('sCL119D23', 3, 8);
INSERT INTO downtime_log VALUES ('sCL119D23', 9, 25);
INSERT INTO downtime_log VALUES ('sCL119D23', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119D23', 16, 30);
INSERT INTO downtime_log VALUES ('sCL119N23', 2, 10);
INSERT INTO downtime_log VALUES ('sCL119N23', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119N23', 9, 10);
INSERT INTO downtime_log VALUES ('sCL119N23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D23', 2, 57);
INSERT INTO downtime_log VALUES ('sCL152D23', 3, 23);
INSERT INTO downtime_log VALUES ('sCL152D23', 9, 50);
INSERT INTO downtime_log VALUES ('sCL152D23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D23', 16, 20);
INSERT INTO downtime_log VALUES ('sCL152N23', 2, 40);
INSERT INTO downtime_log VALUES ('sCL152N23', 3, 25);
INSERT INTO downtime_log VALUES ('sCL152N23', 9, 55);
INSERT INTO downtime_log VALUES ('sCL152N23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D23', 2, 42);
INSERT INTO downtime_log VALUES ('sCL153D23', 3, 23);
INSERT INTO downtime_log VALUES ('sCL153D23', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153D23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D23', 16, 20);
INSERT INTO downtime_log VALUES ('sCL153N23', 2, 40);
INSERT INTO downtime_log VALUES ('sCL153N23', 3, 25);
INSERT INTO downtime_log VALUES ('sCL153N23', 9, 55);
INSERT INTO downtime_log VALUES ('sCL153N23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D23', 2, 32);
INSERT INTO downtime_log VALUES ('sCL170D23', 3, 8);
INSERT INTO downtime_log VALUES ('sCL170D23', 9, 80);
INSERT INTO downtime_log VALUES ('sCL170D23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D23', 16, 150);
INSERT INTO downtime_log VALUES ('sCL170N23', 2, 50);
INSERT INTO downtime_log VALUES ('sCL170N23', 3, 20);
INSERT INTO downtime_log VALUES ('sCL170N23', 9, 50);
INSERT INTO downtime_log VALUES ('sCL170N23', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171D23', 2, 32);
INSERT INTO downtime_log VALUES ('sCL171D23', 3, 8);
INSERT INTO downtime_log VALUES ('sCL171D23', 9, 80);
INSERT INTO downtime_log VALUES ('sCL171D23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171D23', 16, 160);
INSERT INTO downtime_log VALUES ('sCL171N23', 2, 50);
INSERT INTO downtime_log VALUES ('sCL171N23', 3, 20);
INSERT INTO downtime_log VALUES ('sCL171N23', 9, 40);
INSERT INTO downtime_log VALUES ('sCL171N23', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178D23', 2, 32);
INSERT INTO downtime_log VALUES ('sCL178D23', 3, 8);
INSERT INTO downtime_log VALUES ('sCL178D23', 9, 80);
INSERT INTO downtime_log VALUES ('sCL178D23', 14, 10);
INSERT INTO downtime_log VALUES ('sCL178D23', 16, 150);
INSERT INTO downtime_log VALUES ('sCL178N23', 2, 50);
INSERT INTO downtime_log VALUES ('sCL178N23', 3, 20);
INSERT INTO downtime_log VALUES ('sCL178N23', 9, 50);
INSERT INTO downtime_log VALUES ('sCL178N23', 14, 30);
INSERT INTO downtime_log VALUES ('sCL118D24', 2, 19);
INSERT INTO downtime_log VALUES ('sCL118D24', 3, 11);
INSERT INTO downtime_log VALUES ('sCL118D24', 9, 25);
INSERT INTO downtime_log VALUES ('sCL118D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL118N24', 2, 20);
INSERT INTO downtime_log VALUES ('sCL118N24', 3, 10);
INSERT INTO downtime_log VALUES ('sCL118N24', 7, 20);
INSERT INTO downtime_log VALUES ('sCL118N24', 9, 20);
INSERT INTO downtime_log VALUES ('sCL118N24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL119D24', 2, 19);
INSERT INTO downtime_log VALUES ('sCL119D24', 3, 16);
INSERT INTO downtime_log VALUES ('sCL119D24', 9, 30);
INSERT INTO downtime_log VALUES ('sCL119D24', 14, 15);
INSERT INTO downtime_log VALUES ('sCL119N24', 2, 20);
INSERT INTO downtime_log VALUES ('sCL119N24', 3, 10);
INSERT INTO downtime_log VALUES ('sCL119N24', 7, 20);
INSERT INTO downtime_log VALUES ('sCL119N24', 9, 20);
INSERT INTO downtime_log VALUES ('sCL119N24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152D24', 2, 38);
INSERT INTO downtime_log VALUES ('sCL152D24', 3, 22);
INSERT INTO downtime_log VALUES ('sCL152D24', 9, 50);
INSERT INTO downtime_log VALUES ('sCL152D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL152N24', 2, 37);
INSERT INTO downtime_log VALUES ('sCL152N24', 3, 23);
INSERT INTO downtime_log VALUES ('sCL152N24', 9, 40);
INSERT INTO downtime_log VALUES ('sCL152N24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153D24', 2, 38);
INSERT INTO downtime_log VALUES ('sCL153D24', 3, 22);
INSERT INTO downtime_log VALUES ('sCL153D24', 9, 50);
INSERT INTO downtime_log VALUES ('sCL153D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL153N24', 2, 67);
INSERT INTO downtime_log VALUES ('sCL153N24', 3, 28);
INSERT INTO downtime_log VALUES ('sCL153N24', 9, 45);
INSERT INTO downtime_log VALUES ('sCL153N24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D24', 2, 22);
INSERT INTO downtime_log VALUES ('sCL170D24', 3, 13);
INSERT INTO downtime_log VALUES ('sCL170D24', 9, 25);
INSERT INTO downtime_log VALUES ('sCL170D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL170D24', 16, 20);
INSERT INTO downtime_log VALUES ('sCL170N24', 2, 45);
INSERT INTO downtime_log VALUES ('sCL170N24', 3, 20);
INSERT INTO downtime_log VALUES ('sCL170N24', 9, 45);
INSERT INTO downtime_log VALUES ('sCL170N24', 14, 30);
INSERT INTO downtime_log VALUES ('sCL171D24', 2, 22);
INSERT INTO downtime_log VALUES ('sCL171D24', 3, 13);
INSERT INTO downtime_log VALUES ('sCL171D24', 9, 25);
INSERT INTO downtime_log VALUES ('sCL171D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL171D24', 16, 20);
INSERT INTO downtime_log VALUES ('sCL171N24', 2, 50);
INSERT INTO downtime_log VALUES ('sCL171N24', 3, 20);
INSERT INTO downtime_log VALUES ('sCL171N24', 9, 50);
INSERT INTO downtime_log VALUES ('sCL171N24', 14, 30);
INSERT INTO downtime_log VALUES ('sCL178D24', 2, 15);
INSERT INTO downtime_log VALUES ('sCL178D24', 3, 5);
INSERT INTO downtime_log VALUES ('sCL178D24', 9, 30);
INSERT INTO downtime_log VALUES ('sCL178D24', 14, 10);
INSERT INTO downtime_log VALUES ('sCL178D24', 16, 20);
INSERT INTO downtime_log VALUES ('sCL178N24', 2, 50);
INSERT INTO downtime_log VALUES ('sCL178N24', 3, 20);
INSERT INTO downtime_log VALUES ('sCL178N24', 9, 50);
INSERT INTO downtime_log VALUES ('sCL178N24', 14, 20);

-- ---------- reporting views ----------

-- Total loss minutes per log row
CREATE VIEW v_log_loss AS
SELECT p.log_id, COALESCE(SUM(d.minutes), 0) AS downtime_min
FROM production_log p LEFT JOIN downtime_log d ON d.log_id = p.log_id
GROUP BY p.log_id;

-- One row per log with every calculated field (same formulas as the web page and the Excel file)
CREATE VIEW v_production AS
SELECT p.log_id, p.work_date, p.shift, p.machine_id, m.machine_name, m.line, m.machine_type, m.plant, p.item,
       p.std_minutes,
       l.downtime_min,
       p.std_minutes - l.downtime_min                       AS work_min,
       p.input_qty, p.ng_qty,
       p.input_qty - p.ng_qty                               AS ok_qty,
       CASE WHEN COALESCE(p.ct_override_sec, 0) > 0 THEN p.ct_override_sec ELSE COALESCE(m.ct_sec, 0) END AS ct_used_sec,
       CASE WHEN (SELECT setting_value FROM setting WHERE setting_key = 'base') = 'op'
            THEN CAST((SELECT setting_value FROM setting WHERE setting_key = 'op_hours') AS NUMERIC) * 60
            ELSE p.std_minutes END                          AS base_min,
       CASE WHEN COALESCE(p.working_hours, 0) > 0 THEN p.working_hours ELSE p.std_minutes / 60.0 END AS working_hours_used,
       CASE WHEN COALESCE(m.efficiency, 0) > 0 THEN m.efficiency
            ELSE CAST((SELECT setting_value FROM setting WHERE setting_key = 'efficiency') AS NUMERIC) END AS efficiency_used,
       COALESCE(m.loading_sec, 0)                           AS loading_sec,
       CASE WHEN p.input_qty > 0 OR l.downtime_min > 0 THEN 1 ELSE 0 END AS active_flag
FROM production_log p
JOIN machine m  ON m.machine_id = p.machine_id
JOIN v_log_loss l ON l.log_id = p.log_id;

CREATE VIEW v_production_calc AS
SELECT v.*,
       CASE WHEN v.ct_used_sec > 0 THEN v.working_hours_used * 3600 * v.efficiency_used / (v.ct_used_sec + v.loading_sec) ELSE 0 END AS capa_qty,
       CASE WHEN v.base_min > 0 THEN 1.0 * v.work_min / v.base_min END AS uptime_time
FROM v_production v;

-- Daily uptime per machine and shift (time-based Uptime, 75% target)
CREATE VIEW v_uptime_daily AS
SELECT work_date, shift, machine_id, machine_name, machine_type,
       SUM(ok_qty) AS ok_qty, SUM(work_min) AS work_min, SUM(base_min) AS base_min,
       1.0 * SUM(work_min) / NULLIF(SUM(base_min), 0) AS uptime
FROM v_production_calc WHERE active_flag = 1
GROUP BY work_date, shift, machine_id, machine_name, machine_type;

-- Uptime per week (W1..W5 from week_def) per machine
CREATE VIEW v_uptime_week_machine AS
SELECT w.month_start, w.week_no, v.machine_id, v.machine_type,
       SUM(v.ok_qty) AS ok_qty, SUM(v.capa_qty) AS capa_qty,
       SUM(v.work_min) AS work_min, SUM(v.base_min) AS base_min,
       1.0 * SUM(v.work_min) / NULLIF(SUM(v.base_min), 0) AS uptime,
       1.0 * SUM(v.ok_qty) / NULLIF(SUM(v.capa_qty), 0) AS output_ratio
FROM v_production_calc v JOIN week_def w ON v.work_date BETWEEN w.date_from AND w.date_to
WHERE v.active_flag = 1
GROUP BY w.month_start, w.week_no, v.machine_id, v.machine_type;

-- Uptime per week per machine type (summary table)
CREATE VIEW v_uptime_week_type AS
SELECT w.month_start, w.week_no, v.machine_type,
       SUM(v.ok_qty) AS ok_qty, SUM(v.capa_qty) AS capa_qty,
       SUM(v.work_min) AS work_min, SUM(v.base_min) AS base_min,
       1.0 * SUM(v.work_min) / NULLIF(SUM(v.base_min), 0) AS uptime,
       1.0 * SUM(v.ok_qty) / NULLIF(SUM(v.capa_qty), 0) AS output_ratio
FROM v_production_calc v JOIN week_def w ON v.work_date BETWEEN w.date_from AND w.date_to
WHERE v.active_flag = 1
GROUP BY w.month_start, w.week_no, v.machine_type;

-- Downtime Pareto (add WHERE on work_date to limit the period; join production_log for the date)
CREATE VIEW v_downtime_pareto AS
SELECT c.cause_id, c.name_th, c.name_en,
       COALESCE(SUM(d.minutes), 0) AS minutes,
       COALESCE(SUM(d.minutes), 0) / 60.0 AS hours
FROM downtime_cause c LEFT JOIN downtime_log d ON d.cause_id = c.cause_id
GROUP BY c.cause_id, c.name_th, c.name_en;

CREATE VIEW v_downtime_by_machine AS
SELECT p.machine_id, d.cause_id, SUM(d.minutes) AS minutes
FROM downtime_log d JOIN production_log p ON p.log_id = d.log_id
GROUP BY p.machine_id, d.cause_id;

-- Example: uptime of each machine in week 4
-- SELECT * FROM v_uptime_week_machine WHERE week_no = 4 ORDER BY uptime;