CREATE TABLE "treatments"(
    "id" INTEGER NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
CREATE INDEX "treatments_id_name_index" ON
    "treatments"("id", "name");
ALTER TABLE
    "treatments" ADD PRIMARY KEY("id");
CREATE TABLE "medical_hist_treatments"(
    "medical_histories_id" INTEGER NOT NULL,
    "treatments_id" INTEGER NOT NULL
);
ALTER TABLE
    "medical_hist_treatments" ADD PRIMARY KEY("medical_histories_id");
ALTER TABLE
    "medical_hist_treatments" ADD PRIMARY KEY("treatments_id");
CREATE TABLE "invoices_items"(
    "id" INTEGER NOT NULL,
    "unit_price" DECIMAL(8, 2) NOT NULL,
    "quatinty" INTEGER NOT NULL,
    "total_price" DECIMAL(8, 2) NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "treatment_id" INTEGER NOT NULL
);
CREATE INDEX "invoices_items_id_invoice_id_treatment_id_index" ON
    "invoices_items"("id", "invoice_id", "treatment_id");
ALTER TABLE
    "invoices_items" ADD PRIMARY KEY("id");
CREATE TABLE "medical_histories"(
    "id" INTEGER NOT NULL,
    "admitted_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "patient_id" INTEGER NOT NULL,
    "status" VARCHAR(255) NOT NULL
);
CREATE INDEX "medical_histories_id_patient_id_index" ON
    "medical_histories"("id", "patient_id");
ALTER TABLE
    "medical_histories" ADD PRIMARY KEY("id");
CREATE TABLE "patients"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL
);
CREATE INDEX "patients_id_name_index" ON
    "patients"("id", "name");
ALTER TABLE
    "patients" ADD PRIMARY KEY("id");
CREATE TABLE "invoices"(
    "id" INTEGER NOT NULL,
    "total_amount" DECIMAL(8, 2) NOT NULL,
    "generated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "payed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "medical_history_id" INTEGER NOT NULL
);
CREATE INDEX "invoices_id_index" ON
    "invoices"("id");
ALTER TABLE
    "invoices" ADD PRIMARY KEY("id");
ALTER TABLE
    "medical_hist_treatments" ADD CONSTRAINT "medical_hist_treatments_treatments_id_foreign" FOREIGN KEY("treatments_id") REFERENCES "treatments"("id");
ALTER TABLE
    "invoices_items" ADD CONSTRAINT "invoices_items_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");
ALTER TABLE
    "invoices_items" ADD CONSTRAINT "invoices_items_invoice_id_foreign" FOREIGN KEY("invoice_id") REFERENCES "invoices"("id");
ALTER TABLE
    "invoices" ADD CONSTRAINT "invoices_medical_history_id_foreign" FOREIGN KEY("medical_history_id") REFERENCES "medical_histories"("id");
ALTER TABLE
    "medical_hist_treatments" ADD CONSTRAINT "medical_hist_treatments_medical_histories_id_foreign" FOREIGN KEY("medical_histories_id") REFERENCES "medical_histories"("id");
ALTER TABLE
    "medical_histories" ADD CONSTRAINT "medical_histories_patient_id_foreign" FOREIGN KEY("patient_id") REFERENCES "patients"("id");