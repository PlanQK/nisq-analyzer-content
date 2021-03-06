--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Debian 12.5-1.pgdg100+1)
-- Dumped by pg_dump version 12.5 (Debian 12.5-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: analysis_result; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.analysis_result (
    id uuid NOT NULL,
    analyzed_depth integer NOT NULL,
    analyzed_width integer NOT NULL,
    implemented_algorithm uuid,
    provider character varying(255),
    qpu character varying(255),
    sdk_connector character varying(255),
    "time" timestamp without time zone,
    implementation_id uuid
);


ALTER TABLE public.analysis_result OWNER TO nisq;

--
-- Name: analysis_result_input_parameters; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.analysis_result_input_parameters (
    analysis_result_id uuid NOT NULL,
    input_parameters character varying(255),
    input_parameters_key character varying(255) NOT NULL
);


ALTER TABLE public.analysis_result_input_parameters OWNER TO nisq;

--
-- Name: compilation_job; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.compilation_job (
    id uuid NOT NULL,
    ready boolean NOT NULL
);


ALTER TABLE public.compilation_job OWNER TO nisq;

--
-- Name: compilation_job_job_results; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.compilation_job_job_results (
    compilation_job_id uuid NOT NULL,
    job_results_id uuid NOT NULL
);


ALTER TABLE public.compilation_job_job_results OWNER TO nisq;

--
-- Name: compilation_result; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.compilation_result (
    id uuid NOT NULL,
    analyzed_depth integer NOT NULL,
    analyzed_width integer NOT NULL,
    circuit_name character varying(255),
    compiler character varying(255),
    initial_circuit text,
    provider character varying(255),
    qpu character varying(255),
    "time" timestamp without time zone,
    token character varying(255),
    transpiled_circuit text,
    transpiled_language character varying(255)
);


ALTER TABLE public.compilation_result OWNER TO nisq;

--
-- Name: execution_result; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.execution_result (
    id uuid NOT NULL,
    result text,
    status integer,
    status_code character varying(255),
    analysis_result_id uuid,
    compilation_result_id uuid,
    executed_implementation_id uuid
);


ALTER TABLE public.execution_result OWNER TO nisq;

--
-- Name: implementation; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.implementation (
    id uuid NOT NULL,
    file_location character varying(255),
    implemented_algorithm uuid,
    language character varying(255),
    name character varying(255),
    selection_rule character varying(255),
    sdk_id uuid
);


ALTER TABLE public.implementation OWNER TO nisq;

--
-- Name: implementation_execution_results; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.implementation_execution_results (
    implementation_id uuid NOT NULL,
    execution_results_id uuid NOT NULL
);


ALTER TABLE public.implementation_execution_results OWNER TO nisq;

--
-- Name: implementation_input_parameters; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.implementation_input_parameters (
    implementation_id uuid NOT NULL,
    input_parameters_id uuid NOT NULL
);


ALTER TABLE public.implementation_input_parameters OWNER TO nisq;

--
-- Name: implementation_output_parameters; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.implementation_output_parameters (
    implementation_id uuid NOT NULL,
    output_parameters_id uuid NOT NULL
);


ALTER TABLE public.implementation_output_parameters OWNER TO nisq;

--
-- Name: parameter; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.parameter (
    id uuid NOT NULL,
    description character varying(255),
    name character varying(255),
    restriction character varying(255),
    type integer
);


ALTER TABLE public.parameter OWNER TO nisq;

--
-- Name: sdk; Type: TABLE; Schema: public; Owner: nisq
--

CREATE TABLE public.sdk (
    id uuid NOT NULL,
    name character varying(255)
);


ALTER TABLE public.sdk OWNER TO nisq;

--
-- Name: analysis_result_input_parameters analysis_result_input_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.analysis_result_input_parameters
    ADD CONSTRAINT analysis_result_input_parameters_pkey PRIMARY KEY (analysis_result_id, input_parameters_key);


--
-- Name: analysis_result analysis_result_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.analysis_result
    ADD CONSTRAINT analysis_result_pkey PRIMARY KEY (id);


--
-- Name: compilation_job compilation_job_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.compilation_job
    ADD CONSTRAINT compilation_job_pkey PRIMARY KEY (id);


--
-- Name: compilation_result compilation_result_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.compilation_result
    ADD CONSTRAINT compilation_result_pkey PRIMARY KEY (id);


--
-- Name: execution_result execution_result_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.execution_result
    ADD CONSTRAINT execution_result_pkey PRIMARY KEY (id);


--
-- Name: implementation implementation_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation
    ADD CONSTRAINT implementation_pkey PRIMARY KEY (id);


--
-- Name: parameter parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.parameter
    ADD CONSTRAINT parameter_pkey PRIMARY KEY (id);


--
-- Name: sdk sdk_pkey; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.sdk
    ADD CONSTRAINT sdk_pkey PRIMARY KEY (id);


--
-- Name: compilation_job_job_results uk_28skth2ceqc642wia5j56j4vs; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.compilation_job_job_results
    ADD CONSTRAINT uk_28skth2ceqc642wia5j56j4vs UNIQUE (job_results_id);


--
-- Name: implementation_input_parameters uk_cok59x3vgd8xwhb4fwav79t10; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_input_parameters
    ADD CONSTRAINT uk_cok59x3vgd8xwhb4fwav79t10 UNIQUE (input_parameters_id);


--
-- Name: implementation_output_parameters uk_qnecksht5j0iksderlbdyx4v; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_output_parameters
    ADD CONSTRAINT uk_qnecksht5j0iksderlbdyx4v UNIQUE (output_parameters_id);


--
-- Name: implementation_execution_results uk_qq2knbyl7yfs28gbcga9oucj; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_execution_results
    ADD CONSTRAINT uk_qq2knbyl7yfs28gbcga9oucj UNIQUE (execution_results_id);


--
-- Name: sdk uk_tie0wxox8cj4d5nrmn1y9wif1; Type: CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.sdk
    ADD CONSTRAINT uk_tie0wxox8cj4d5nrmn1y9wif1 UNIQUE (name);


--
-- Name: analysis_result_input_parameters fk17iggcapwf03u4jjs8saabweb; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.analysis_result_input_parameters
    ADD CONSTRAINT fk17iggcapwf03u4jjs8saabweb FOREIGN KEY (analysis_result_id) REFERENCES public.analysis_result(id);


--
-- Name: implementation_input_parameters fk2ac09oep1t8yr2wo51yk5l9ht; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_input_parameters
    ADD CONSTRAINT fk2ac09oep1t8yr2wo51yk5l9ht FOREIGN KEY (implementation_id) REFERENCES public.implementation(id);


--
-- Name: compilation_job_job_results fk3bim70bchqfnydkljy7f0blw0; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.compilation_job_job_results
    ADD CONSTRAINT fk3bim70bchqfnydkljy7f0blw0 FOREIGN KEY (job_results_id) REFERENCES public.compilation_result(id);


--
-- Name: implementation_input_parameters fk66ltck2e65pwb4a0sel5rq8f1; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_input_parameters
    ADD CONSTRAINT fk66ltck2e65pwb4a0sel5rq8f1 FOREIGN KEY (input_parameters_id) REFERENCES public.parameter(id);


--
-- Name: implementation_output_parameters fk9dfdtclo8y0v87b1iebr3p6lw; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_output_parameters
    ADD CONSTRAINT fk9dfdtclo8y0v87b1iebr3p6lw FOREIGN KEY (output_parameters_id) REFERENCES public.parameter(id);


--
-- Name: implementation_execution_results fkcbsjlbnwq7x0gvltksi1y1205; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_execution_results
    ADD CONSTRAINT fkcbsjlbnwq7x0gvltksi1y1205 FOREIGN KEY (execution_results_id) REFERENCES public.execution_result(id);


--
-- Name: compilation_job_job_results fkd1efpsafu9jpgbkh8w3j6t112; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.compilation_job_job_results
    ADD CONSTRAINT fkd1efpsafu9jpgbkh8w3j6t112 FOREIGN KEY (compilation_job_id) REFERENCES public.compilation_job(id);


--
-- Name: implementation_output_parameters fkhor56dtojk0mt63jf8hi565gx; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_output_parameters
    ADD CONSTRAINT fkhor56dtojk0mt63jf8hi565gx FOREIGN KEY (implementation_id) REFERENCES public.implementation(id);


--
-- Name: execution_result fkie5mgayvkqvlay8eylv01r29g; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.execution_result
    ADD CONSTRAINT fkie5mgayvkqvlay8eylv01r29g FOREIGN KEY (executed_implementation_id) REFERENCES public.implementation(id);


--
-- Name: analysis_result fkkg46r78o8o1brxnvbrlvg1mqo; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.analysis_result
    ADD CONSTRAINT fkkg46r78o8o1brxnvbrlvg1mqo FOREIGN KEY (implementation_id) REFERENCES public.implementation(id);


--
-- Name: execution_result fkld7avvfa0sgn4vefk0hycr3pq; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.execution_result
    ADD CONSTRAINT fkld7avvfa0sgn4vefk0hycr3pq FOREIGN KEY (analysis_result_id) REFERENCES public.analysis_result(id);


--
-- Name: implementation fkn33hfev7eeu6je19kat24j6b0; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation
    ADD CONSTRAINT fkn33hfev7eeu6je19kat24j6b0 FOREIGN KEY (sdk_id) REFERENCES public.sdk(id);


--
-- Name: execution_result fkr2fnw3lld5ndb46wjbdiqutkk; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.execution_result
    ADD CONSTRAINT fkr2fnw3lld5ndb46wjbdiqutkk FOREIGN KEY (compilation_result_id) REFERENCES public.compilation_result(id);


--
-- Name: implementation_execution_results fkt54sku19teb6etv0a9lcitk6g; Type: FK CONSTRAINT; Schema: public; Owner: nisq
--

ALTER TABLE ONLY public.implementation_execution_results
    ADD CONSTRAINT fkt54sku19teb6etv0a9lcitk6g FOREIGN KEY (implementation_id) REFERENCES public.implementation(id);


--
-- PostgreSQL database dump complete
--

