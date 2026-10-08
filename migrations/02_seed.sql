--
-- PostgreSQL database dump
--

\restrict 07Cr0yNCkadRSORh5DKjenz3T3p6wx9PC7HXa6pmWMmmuCYXMdbGXVxr7zIoc2A

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: category; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.category (category_id, name, description) FROM stdin;
1	Pizza	Pizza and Italian-style baked dishes
2	Burgers	Burgers and fast food
3	Chicken	Chicken dishes
4	Sushi	Sushi and Japanese food
5	Asian	Asian cuisine
6	Salads	Fresh salads and healthy food
7	Desserts	Desserts and sweets
8	Drinks	Cold and hot drinks
9	Breakfast	Breakfast dishes
10	Kazakh Cuisine	Traditional Kazakh food
\.


--
-- Data for Name: courier; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.courier (courier_id, full_name, phone, transport_type, rating, hire_date, created_at) FROM stdin;
1	Courier 1	+77020000001	motorcycle	4.1	2026-01-02	2026-10-05 12:54:41.71089+05
2	Courier 2	+77020000002	bicycle	4.2	2026-01-03	2026-10-05 12:54:41.71089+05
3	Courier 3	+77020000003	scooter	4.3	2026-01-04	2026-10-05 12:54:41.71089+05
4	Courier 4	+77020000004	walking	4.4	2026-01-05	2026-10-05 12:54:41.71089+05
5	Courier 5	+77020000005	car	4.5	2026-01-06	2026-10-05 12:54:41.71089+05
6	Courier 6	+77020000006	motorcycle	4.6	2026-01-07	2026-10-05 12:54:41.71089+05
7	Courier 7	+77020000007	bicycle	4.7	2026-01-08	2026-10-05 12:54:41.71089+05
8	Courier 8	+77020000008	scooter	4.8	2026-01-09	2026-10-05 12:54:41.71089+05
9	Courier 9	+77020000009	walking	4.9	2026-01-10	2026-10-05 12:54:41.71089+05
10	Courier 10	+77020000010	car	4.0	2026-01-11	2026-10-05 12:54:41.71089+05
11	Courier 11	+77020000011	motorcycle	4.1	2026-01-12	2026-10-05 12:54:41.71089+05
12	Courier 12	+77020000012	bicycle	4.2	2026-01-13	2026-10-05 12:54:41.71089+05
13	Courier 13	+77020000013	scooter	4.3	2026-01-14	2026-10-05 12:54:41.71089+05
14	Courier 14	+77020000014	walking	4.4	2026-01-15	2026-10-05 12:54:41.71089+05
15	Courier 15	+77020000015	car	4.5	2026-01-16	2026-10-05 12:54:41.71089+05
16	Courier 16	+77020000016	motorcycle	4.6	2026-01-17	2026-10-05 12:54:41.71089+05
17	Courier 17	+77020000017	bicycle	4.7	2026-01-18	2026-10-05 12:54:41.71089+05
18	Courier 18	+77020000018	scooter	4.8	2026-01-19	2026-10-05 12:54:41.71089+05
19	Courier 19	+77020000019	walking	4.9	2026-01-20	2026-10-05 12:54:41.71089+05
20	Courier 20	+77020000020	car	4.0	2026-01-21	2026-10-05 12:54:41.71089+05
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.customer (customer_id, full_name, phone, email, address, created_at) FROM stdin;
1	Customer 1	+77010000001	customer1@mail.kz	Almaty, Street 1, House 1	2026-09-01 10:00:00+05
2	Customer 2	+77010000002	customer2@mail.kz	Almaty, Street 2, House 2	2026-09-01 11:00:00+05
3	Customer 3	+77010000003	customer3@mail.kz	Almaty, Street 3, House 3	2026-09-01 12:00:00+05
4	Customer 4	+77010000004	customer4@mail.kz	Almaty, Street 4, House 4	2026-09-01 13:00:00+05
5	Customer 5	+77010000005	customer5@mail.kz	Almaty, Street 5, House 5	2026-09-01 14:00:00+05
6	Customer 6	+77010000006	customer6@mail.kz	Almaty, Street 6, House 6	2026-09-01 15:00:00+05
7	Customer 7	+77010000007	customer7@mail.kz	Almaty, Street 7, House 7	2026-09-01 16:00:00+05
8	Customer 8	+77010000008	customer8@mail.kz	Almaty, Street 8, House 8	2026-09-01 17:00:00+05
9	Customer 9	+77010000009	customer9@mail.kz	Almaty, Street 9, House 9	2026-09-01 18:00:00+05
10	Customer 10	+77010000010	customer10@mail.kz	Almaty, Street 10, House 10	2026-09-01 19:00:00+05
11	Customer 11	+77010000011	customer11@mail.kz	Almaty, Street 11, House 11	2026-09-01 20:00:00+05
12	Customer 12	+77010000012	customer12@mail.kz	Almaty, Street 12, House 12	2026-09-01 21:00:00+05
13	Customer 13	+77010000013	customer13@mail.kz	Almaty, Street 13, House 13	2026-09-01 22:00:00+05
14	Customer 14	+77010000014	customer14@mail.kz	Almaty, Street 14, House 14	2026-09-01 23:00:00+05
15	Customer 15	+77010000015	customer15@mail.kz	Almaty, Street 15, House 15	2026-09-02 00:00:00+05
16	Customer 16	+77010000016	customer16@mail.kz	Almaty, Street 16, House 16	2026-09-02 01:00:00+05
17	Customer 17	+77010000017	customer17@mail.kz	Almaty, Street 17, House 17	2026-09-02 02:00:00+05
18	Customer 18	+77010000018	customer18@mail.kz	Almaty, Street 18, House 18	2026-09-02 03:00:00+05
19	Customer 19	+77010000019	customer19@mail.kz	Almaty, Street 19, House 19	2026-09-02 04:00:00+05
20	Customer 20	+77010000020	customer20@mail.kz	Almaty, Street 20, House 20	2026-09-02 05:00:00+05
21	Customer 21	+77010000021	customer21@mail.kz	Almaty, Street 1, House 21	2026-09-02 06:00:00+05
22	Customer 22	+77010000022	customer22@mail.kz	Almaty, Street 2, House 22	2026-09-02 07:00:00+05
23	Customer 23	+77010000023	customer23@mail.kz	Almaty, Street 3, House 23	2026-09-02 08:00:00+05
24	Customer 24	+77010000024	customer24@mail.kz	Almaty, Street 4, House 24	2026-09-02 09:00:00+05
25	Customer 25	+77010000025	customer25@mail.kz	Almaty, Street 5, House 25	2026-09-02 10:00:00+05
26	Customer 26	+77010000026	customer26@mail.kz	Almaty, Street 6, House 26	2026-09-02 11:00:00+05
27	Customer 27	+77010000027	customer27@mail.kz	Almaty, Street 7, House 27	2026-09-02 12:00:00+05
28	Customer 28	+77010000028	customer28@mail.kz	Almaty, Street 8, House 28	2026-09-02 13:00:00+05
29	Customer 29	+77010000029	customer29@mail.kz	Almaty, Street 9, House 29	2026-09-02 14:00:00+05
30	Customer 30	+77010000030	customer30@mail.kz	Almaty, Street 10, House 30	2026-09-02 15:00:00+05
31	Customer 31	+77010000031	customer31@mail.kz	Almaty, Street 11, House 31	2026-09-02 16:00:00+05
32	Customer 32	+77010000032	customer32@mail.kz	Almaty, Street 12, House 32	2026-09-02 17:00:00+05
33	Customer 33	+77010000033	customer33@mail.kz	Almaty, Street 13, House 33	2026-09-02 18:00:00+05
34	Customer 34	+77010000034	customer34@mail.kz	Almaty, Street 14, House 34	2026-09-02 19:00:00+05
35	Customer 35	+77010000035	customer35@mail.kz	Almaty, Street 15, House 35	2026-09-02 20:00:00+05
36	Customer 36	+77010000036	customer36@mail.kz	Almaty, Street 16, House 36	2026-09-02 21:00:00+05
37	Customer 37	+77010000037	customer37@mail.kz	Almaty, Street 17, House 37	2026-09-02 22:00:00+05
38	Customer 38	+77010000038	customer38@mail.kz	Almaty, Street 18, House 38	2026-09-02 23:00:00+05
39	Customer 39	+77010000039	customer39@mail.kz	Almaty, Street 19, House 39	2026-09-03 00:00:00+05
40	Customer 40	+77010000040	customer40@mail.kz	Almaty, Street 20, House 40	2026-09-03 01:00:00+05
41	Customer 41	+77010000041	customer41@mail.kz	Almaty, Street 1, House 41	2026-09-03 02:00:00+05
42	Customer 42	+77010000042	customer42@mail.kz	Almaty, Street 2, House 42	2026-09-03 03:00:00+05
43	Customer 43	+77010000043	customer43@mail.kz	Almaty, Street 3, House 43	2026-09-03 04:00:00+05
44	Customer 44	+77010000044	customer44@mail.kz	Almaty, Street 4, House 44	2026-09-03 05:00:00+05
45	Customer 45	+77010000045	customer45@mail.kz	Almaty, Street 5, House 45	2026-09-03 06:00:00+05
46	Customer 46	+77010000046	customer46@mail.kz	Almaty, Street 6, House 46	2026-09-03 07:00:00+05
47	Customer 47	+77010000047	customer47@mail.kz	Almaty, Street 7, House 47	2026-09-03 08:00:00+05
48	Customer 48	+77010000048	customer48@mail.kz	Almaty, Street 8, House 48	2026-09-03 09:00:00+05
49	Customer 49	+77010000049	customer49@mail.kz	Almaty, Street 9, House 49	2026-09-03 10:00:00+05
50	Customer 50	+77010000050	customer50@mail.kz	Almaty, Street 10, House 50	2026-09-03 11:00:00+05
\.


--
-- Data for Name: restaurant; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.restaurant (restaurant_id, name, address, phone, rating, created_at) FROM stdin;
1	Dodo Pizza - Auezov	Almaty, Auezov St, 105	\N	\N	2026-10-05 12:54:34.279933+05
2	Dodo Pizza - Baitursynov	Almaty, Baitursynov St, 80	\N	\N	2026-10-05 12:54:34.279933+05
3	Dodo Pizza - Timiryazev	Almaty, Timiryazev St, 74	\N	\N	2026-10-05 12:54:34.279933+05
4	Dodo Pizza - Tole Bi	Almaty, Tole Bi St, 191	\N	\N	2026-10-05 12:54:34.279933+05
5	Dodo Pizza - Altynsarin	Almaty, Altynsarin Ave, 51B	\N	\N	2026-10-05 12:54:34.279933+05
6	Dodo Pizza - Auezov 138B	Almaty, Auezov St, 138B	\N	\N	2026-10-05 12:54:34.279933+05
7	Dodo Pizza - Mustafin	Almaty, Mustafin St, 9	\N	\N	2026-10-05 12:54:34.279933+05
8	Dodo Pizza - Rozybakiev	Almaty, Rozybakiev St, 247A	\N	\N	2026-10-05 12:54:34.279933+05
9	Dodo Pizza - Zhandosov	Almaty, Zhandosov St, 162A/1	\N	\N	2026-10-05 12:54:34.279933+05
10	Dodo Pizza - Nazarbayev	Almaty, Nazarbayev Ave, 220	\N	\N	2026-10-05 12:54:34.279933+05
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.orders (order_id, customer_id, restaurant_id, status, delivery_fee, total_amount, comment, created_at) FROM stdin;
1	1	1	delivered	500.00	7175.00	No onions please	2026-09-01 13:00:00+05
2	2	2	delivered	500.00	6725.00	Leave the order at the door	2026-09-01 16:00:00+05
3	3	3	delivered	500.00	12725.00	Please deliver as soon as possible	2026-09-01 19:00:00+05
4	4	4	delivered	500.00	11675.00	Standard delivery	2026-09-01 22:00:00+05
5	5	5	delivered	500.00	10100.00	Please call before delivery	2026-09-02 01:00:00+05
6	6	6	delivered	500.00	18350.00	No onions please	2026-09-02 04:00:00+05
7	7	7	delivered	500.00	16175.00	Leave the order at the door	2026-09-02 07:00:00+05
8	8	8	delivered	500.00	13475.00	Please deliver as soon as possible	2026-09-02 10:00:00+05
9	9	9	delivered	500.00	23975.00	Standard delivery	2026-09-02 13:00:00+05
10	10	10	delivered	500.00	20675.00	Please call before delivery	2026-09-02 16:00:00+05
11	11	1	delivered	500.00	5600.00	No onions please	2026-09-02 19:00:00+05
12	12	2	delivered	500.00	10850.00	Leave the order at the door	2026-09-02 22:00:00+05
13	13	3	delivered	500.00	10175.00	Please deliver as soon as possible	2026-09-03 01:00:00+05
14	14	4	delivered	500.00	8975.00	Standard delivery	2026-09-03 04:00:00+05
15	15	5	delivered	500.00	16475.00	Please call before delivery	2026-09-03 07:00:00+05
16	16	6	delivered	500.00	14675.00	No onions please	2026-09-03 10:00:00+05
17	17	7	delivered	500.00	12350.00	Leave the order at the door	2026-09-03 13:00:00+05
18	18	8	delivered	500.00	22100.00	Please deliver as soon as possible	2026-09-03 16:00:00+05
19	19	9	delivered	500.00	19175.00	Standard delivery	2026-09-03 19:00:00+05
20	20	10	delivered	500.00	15725.00	Please call before delivery	2026-09-03 22:00:00+05
21	21	1	delivered	500.00	8975.00	No onions please	2026-09-04 01:00:00+05
22	22	2	delivered	500.00	8675.00	Leave the order at the door	2026-09-04 04:00:00+05
23	23	3	delivered	500.00	7850.00	Please deliver as soon as possible	2026-09-04 07:00:00+05
24	24	4	delivered	500.00	14600.00	Standard delivery	2026-09-04 10:00:00+05
25	25	5	delivered	500.00	13175.00	Please call before delivery	2026-09-04 13:00:00+05
26	26	6	delivered	500.00	11225.00	No onions please	2026-09-04 16:00:00+05
27	27	7	delivered	500.00	20225.00	Leave the order at the door	2026-09-04 19:00:00+05
28	28	8	delivered	500.00	17675.00	Please deliver as soon as possible	2026-09-04 22:00:00+05
29	29	9	delivered	500.00	14600.00	Standard delivery	2026-09-05 01:00:00+05
30	30	10	delivered	500.00	25850.00	Please call before delivery	2026-09-05 04:00:00+05
31	31	1	delivered	500.00	7175.00	No onions please	2026-09-05 07:00:00+05
32	32	2	delivered	500.00	6725.00	Leave the order at the door	2026-09-05 10:00:00+05
33	33	3	delivered	500.00	12725.00	Please deliver as soon as possible	2026-09-05 13:00:00+05
34	34	4	delivered	500.00	11675.00	Standard delivery	2026-09-05 16:00:00+05
35	35	5	delivered	500.00	10100.00	Please call before delivery	2026-09-05 19:00:00+05
36	36	6	delivered	500.00	18350.00	No onions please	2026-09-05 22:00:00+05
37	37	7	delivered	500.00	16175.00	Leave the order at the door	2026-09-06 01:00:00+05
38	38	8	delivered	500.00	13475.00	Please deliver as soon as possible	2026-09-06 04:00:00+05
39	39	9	delivered	500.00	23975.00	Standard delivery	2026-09-06 07:00:00+05
40	40	10	delivered	500.00	20675.00	Please call before delivery	2026-09-06 10:00:00+05
41	41	1	delivered	500.00	5600.00	No onions please	2026-09-06 13:00:00+05
42	42	2	delivered	500.00	10850.00	Leave the order at the door	2026-09-06 16:00:00+05
43	43	3	delivered	500.00	10175.00	Please deliver as soon as possible	2026-09-06 19:00:00+05
44	44	4	delivered	500.00	8975.00	Standard delivery	2026-09-06 22:00:00+05
45	45	5	delivered	500.00	16475.00	Please call before delivery	2026-09-07 01:00:00+05
46	46	6	delivered	500.00	14675.00	No onions please	2026-09-07 04:00:00+05
47	47	7	delivered	500.00	12350.00	Leave the order at the door	2026-09-07 07:00:00+05
48	48	8	delivered	500.00	22100.00	Please deliver as soon as possible	2026-09-07 10:00:00+05
49	49	9	delivered	500.00	19175.00	Standard delivery	2026-09-07 13:00:00+05
50	50	10	delivered	500.00	15725.00	Please call before delivery	2026-09-07 16:00:00+05
51	1	1	delivered	500.00	8975.00	No onions please	2026-09-07 19:00:00+05
52	2	2	delivered	500.00	8675.00	Leave the order at the door	2026-09-07 22:00:00+05
53	3	3	delivered	500.00	7850.00	Please deliver as soon as possible	2026-09-08 01:00:00+05
54	4	4	delivered	500.00	14600.00	Standard delivery	2026-09-08 04:00:00+05
55	5	5	delivered	500.00	13175.00	Please call before delivery	2026-09-08 07:00:00+05
56	6	6	delivered	500.00	11225.00	No onions please	2026-09-08 10:00:00+05
57	7	7	delivered	500.00	20225.00	Leave the order at the door	2026-09-08 13:00:00+05
58	8	8	delivered	500.00	17675.00	Please deliver as soon as possible	2026-09-08 16:00:00+05
59	9	9	delivered	500.00	14600.00	Standard delivery	2026-09-08 19:00:00+05
60	10	10	delivered	500.00	25850.00	Please call before delivery	2026-09-08 22:00:00+05
61	11	1	delivered	500.00	7175.00	No onions please	2026-09-09 01:00:00+05
62	12	2	delivered	500.00	6725.00	Leave the order at the door	2026-09-09 04:00:00+05
63	13	3	delivered	500.00	12725.00	Please deliver as soon as possible	2026-09-09 07:00:00+05
64	14	4	delivered	500.00	11675.00	Standard delivery	2026-09-09 10:00:00+05
65	15	5	delivered	500.00	10100.00	Please call before delivery	2026-09-09 13:00:00+05
66	16	6	delivered	500.00	18350.00	No onions please	2026-09-09 16:00:00+05
67	17	7	delivered	500.00	16175.00	Leave the order at the door	2026-09-09 19:00:00+05
68	18	8	delivered	500.00	13475.00	Please deliver as soon as possible	2026-09-09 22:00:00+05
69	19	9	delivered	500.00	23975.00	Standard delivery	2026-09-10 01:00:00+05
70	20	10	delivered	500.00	20675.00	Please call before delivery	2026-09-10 04:00:00+05
71	21	1	delivered	500.00	5600.00	No onions please	2026-09-10 07:00:00+05
72	22	2	delivered	500.00	10850.00	Leave the order at the door	2026-09-10 10:00:00+05
73	23	3	delivered	500.00	10175.00	Please deliver as soon as possible	2026-09-10 13:00:00+05
74	24	4	delivered	500.00	8975.00	Standard delivery	2026-09-10 16:00:00+05
75	25	5	delivered	500.00	16475.00	Please call before delivery	2026-09-10 19:00:00+05
76	26	6	delivered	500.00	14675.00	No onions please	2026-09-10 22:00:00+05
77	27	7	delivered	500.00	12350.00	Leave the order at the door	2026-09-11 01:00:00+05
78	28	8	delivered	500.00	22100.00	Please deliver as soon as possible	2026-09-11 04:00:00+05
79	29	9	delivered	500.00	19175.00	Standard delivery	2026-09-11 07:00:00+05
80	30	10	delivered	500.00	15725.00	Please call before delivery	2026-09-11 10:00:00+05
81	31	1	cancelled	500.00	8975.00	No onions please	2026-09-11 13:00:00+05
82	32	2	cancelled	500.00	8675.00	Leave the order at the door	2026-09-11 16:00:00+05
83	33	3	cancelled	500.00	7850.00	Please deliver as soon as possible	2026-09-11 19:00:00+05
84	34	4	cancelled	500.00	14600.00	Standard delivery	2026-09-11 22:00:00+05
85	35	5	cancelled	500.00	13175.00	Please call before delivery	2026-09-12 01:00:00+05
86	36	6	cancelled	500.00	11225.00	No onions please	2026-09-12 04:00:00+05
87	37	7	cancelled	500.00	20225.00	Leave the order at the door	2026-09-12 07:00:00+05
88	38	8	cancelled	500.00	17675.00	Please deliver as soon as possible	2026-09-12 10:00:00+05
89	39	9	cancelled	500.00	14600.00	Standard delivery	2026-09-12 13:00:00+05
90	40	10	cancelled	500.00	25850.00	Please call before delivery	2026-09-12 16:00:00+05
91	41	1	on_the_way	500.00	7175.00	No onions please	2026-09-12 19:00:00+05
92	42	2	on_the_way	500.00	6725.00	Leave the order at the door	2026-09-12 22:00:00+05
93	43	3	on_the_way	500.00	12725.00	Please deliver as soon as possible	2026-09-13 01:00:00+05
94	44	4	on_the_way	500.00	11675.00	Standard delivery	2026-09-13 04:00:00+05
95	45	5	on_the_way	500.00	10100.00	Please call before delivery	2026-09-13 07:00:00+05
96	46	6	on_the_way	500.00	18350.00	No onions please	2026-09-13 10:00:00+05
97	47	7	on_the_way	500.00	16175.00	Leave the order at the door	2026-09-13 13:00:00+05
98	48	8	on_the_way	500.00	13475.00	Please deliver as soon as possible	2026-09-13 16:00:00+05
99	49	9	on_the_way	500.00	23975.00	Standard delivery	2026-09-13 19:00:00+05
100	50	10	on_the_way	500.00	20675.00	Please call before delivery	2026-09-13 22:00:00+05
\.


--
-- Data for Name: delivery; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.delivery (delivery_id, order_id, courier_id, delivery_address, status, picked_up_at, delivered_at, created_at) FROM stdin;
1	51	11	Almaty, Street 1, House 1	delivered	2026-09-07 19:20:00+05	2026-09-07 19:55:00+05	2026-09-07 19:00:00+05
2	1	1	Almaty, Street 1, House 1	delivered	2026-09-01 13:20:00+05	2026-09-01 13:55:00+05	2026-09-01 13:00:00+05
3	52	12	Almaty, Street 2, House 2	delivered	2026-09-07 22:20:00+05	2026-09-07 22:55:00+05	2026-09-07 22:00:00+05
4	2	2	Almaty, Street 2, House 2	delivered	2026-09-01 16:20:00+05	2026-09-01 16:55:00+05	2026-09-01 16:00:00+05
5	53	13	Almaty, Street 3, House 3	delivered	2026-09-08 01:20:00+05	2026-09-08 01:55:00+05	2026-09-08 01:00:00+05
6	3	3	Almaty, Street 3, House 3	delivered	2026-09-01 19:20:00+05	2026-09-01 19:55:00+05	2026-09-01 19:00:00+05
7	54	14	Almaty, Street 4, House 4	delivered	2026-09-08 04:20:00+05	2026-09-08 04:55:00+05	2026-09-08 04:00:00+05
8	4	4	Almaty, Street 4, House 4	delivered	2026-09-01 22:20:00+05	2026-09-01 22:55:00+05	2026-09-01 22:00:00+05
9	55	15	Almaty, Street 5, House 5	delivered	2026-09-08 07:20:00+05	2026-09-08 07:55:00+05	2026-09-08 07:00:00+05
10	5	5	Almaty, Street 5, House 5	delivered	2026-09-02 01:20:00+05	2026-09-02 01:55:00+05	2026-09-02 01:00:00+05
11	56	16	Almaty, Street 6, House 6	delivered	2026-09-08 10:20:00+05	2026-09-08 10:55:00+05	2026-09-08 10:00:00+05
12	6	6	Almaty, Street 6, House 6	delivered	2026-09-02 04:20:00+05	2026-09-02 04:55:00+05	2026-09-02 04:00:00+05
13	57	17	Almaty, Street 7, House 7	delivered	2026-09-08 13:20:00+05	2026-09-08 13:55:00+05	2026-09-08 13:00:00+05
14	7	7	Almaty, Street 7, House 7	delivered	2026-09-02 07:20:00+05	2026-09-02 07:55:00+05	2026-09-02 07:00:00+05
15	58	18	Almaty, Street 8, House 8	delivered	2026-09-08 16:20:00+05	2026-09-08 16:55:00+05	2026-09-08 16:00:00+05
16	8	8	Almaty, Street 8, House 8	delivered	2026-09-02 10:20:00+05	2026-09-02 10:55:00+05	2026-09-02 10:00:00+05
17	59	19	Almaty, Street 9, House 9	delivered	2026-09-08 19:20:00+05	2026-09-08 19:55:00+05	2026-09-08 19:00:00+05
18	9	9	Almaty, Street 9, House 9	delivered	2026-09-02 13:20:00+05	2026-09-02 13:55:00+05	2026-09-02 13:00:00+05
19	60	20	Almaty, Street 10, House 10	delivered	2026-09-08 22:20:00+05	2026-09-08 22:55:00+05	2026-09-08 22:00:00+05
20	10	10	Almaty, Street 10, House 10	delivered	2026-09-02 16:20:00+05	2026-09-02 16:55:00+05	2026-09-02 16:00:00+05
21	61	1	Almaty, Street 11, House 11	delivered	2026-09-09 01:20:00+05	2026-09-09 01:55:00+05	2026-09-09 01:00:00+05
22	11	11	Almaty, Street 11, House 11	delivered	2026-09-02 19:20:00+05	2026-09-02 19:55:00+05	2026-09-02 19:00:00+05
23	62	2	Almaty, Street 12, House 12	delivered	2026-09-09 04:20:00+05	2026-09-09 04:55:00+05	2026-09-09 04:00:00+05
24	12	12	Almaty, Street 12, House 12	delivered	2026-09-02 22:20:00+05	2026-09-02 22:55:00+05	2026-09-02 22:00:00+05
25	63	3	Almaty, Street 13, House 13	delivered	2026-09-09 07:20:00+05	2026-09-09 07:55:00+05	2026-09-09 07:00:00+05
26	13	13	Almaty, Street 13, House 13	delivered	2026-09-03 01:20:00+05	2026-09-03 01:55:00+05	2026-09-03 01:00:00+05
27	64	4	Almaty, Street 14, House 14	delivered	2026-09-09 10:20:00+05	2026-09-09 10:55:00+05	2026-09-09 10:00:00+05
28	14	14	Almaty, Street 14, House 14	delivered	2026-09-03 04:20:00+05	2026-09-03 04:55:00+05	2026-09-03 04:00:00+05
29	65	5	Almaty, Street 15, House 15	delivered	2026-09-09 13:20:00+05	2026-09-09 13:55:00+05	2026-09-09 13:00:00+05
30	15	15	Almaty, Street 15, House 15	delivered	2026-09-03 07:20:00+05	2026-09-03 07:55:00+05	2026-09-03 07:00:00+05
31	66	6	Almaty, Street 16, House 16	delivered	2026-09-09 16:20:00+05	2026-09-09 16:55:00+05	2026-09-09 16:00:00+05
32	16	16	Almaty, Street 16, House 16	delivered	2026-09-03 10:20:00+05	2026-09-03 10:55:00+05	2026-09-03 10:00:00+05
33	67	7	Almaty, Street 17, House 17	delivered	2026-09-09 19:20:00+05	2026-09-09 19:55:00+05	2026-09-09 19:00:00+05
34	17	17	Almaty, Street 17, House 17	delivered	2026-09-03 13:20:00+05	2026-09-03 13:55:00+05	2026-09-03 13:00:00+05
35	68	8	Almaty, Street 18, House 18	delivered	2026-09-09 22:20:00+05	2026-09-09 22:55:00+05	2026-09-09 22:00:00+05
36	18	18	Almaty, Street 18, House 18	delivered	2026-09-03 16:20:00+05	2026-09-03 16:55:00+05	2026-09-03 16:00:00+05
37	69	9	Almaty, Street 19, House 19	delivered	2026-09-10 01:20:00+05	2026-09-10 01:55:00+05	2026-09-10 01:00:00+05
38	19	19	Almaty, Street 19, House 19	delivered	2026-09-03 19:20:00+05	2026-09-03 19:55:00+05	2026-09-03 19:00:00+05
39	70	10	Almaty, Street 20, House 20	delivered	2026-09-10 04:20:00+05	2026-09-10 04:55:00+05	2026-09-10 04:00:00+05
40	20	20	Almaty, Street 20, House 20	delivered	2026-09-03 22:20:00+05	2026-09-03 22:55:00+05	2026-09-03 22:00:00+05
41	71	11	Almaty, Street 1, House 21	delivered	2026-09-10 07:20:00+05	2026-09-10 07:55:00+05	2026-09-10 07:00:00+05
42	21	1	Almaty, Street 1, House 21	delivered	2026-09-04 01:20:00+05	2026-09-04 01:55:00+05	2026-09-04 01:00:00+05
43	72	12	Almaty, Street 2, House 22	delivered	2026-09-10 10:20:00+05	2026-09-10 10:55:00+05	2026-09-10 10:00:00+05
44	22	2	Almaty, Street 2, House 22	delivered	2026-09-04 04:20:00+05	2026-09-04 04:55:00+05	2026-09-04 04:00:00+05
45	73	13	Almaty, Street 3, House 23	delivered	2026-09-10 13:20:00+05	2026-09-10 13:55:00+05	2026-09-10 13:00:00+05
46	23	3	Almaty, Street 3, House 23	delivered	2026-09-04 07:20:00+05	2026-09-04 07:55:00+05	2026-09-04 07:00:00+05
47	74	14	Almaty, Street 4, House 24	delivered	2026-09-10 16:20:00+05	2026-09-10 16:55:00+05	2026-09-10 16:00:00+05
48	24	4	Almaty, Street 4, House 24	delivered	2026-09-04 10:20:00+05	2026-09-04 10:55:00+05	2026-09-04 10:00:00+05
49	75	15	Almaty, Street 5, House 25	delivered	2026-09-10 19:20:00+05	2026-09-10 19:55:00+05	2026-09-10 19:00:00+05
50	25	5	Almaty, Street 5, House 25	delivered	2026-09-04 13:20:00+05	2026-09-04 13:55:00+05	2026-09-04 13:00:00+05
51	76	16	Almaty, Street 6, House 26	delivered	2026-09-10 22:20:00+05	2026-09-10 22:55:00+05	2026-09-10 22:00:00+05
52	26	6	Almaty, Street 6, House 26	delivered	2026-09-04 16:20:00+05	2026-09-04 16:55:00+05	2026-09-04 16:00:00+05
53	77	17	Almaty, Street 7, House 27	delivered	2026-09-11 01:20:00+05	2026-09-11 01:55:00+05	2026-09-11 01:00:00+05
54	27	7	Almaty, Street 7, House 27	delivered	2026-09-04 19:20:00+05	2026-09-04 19:55:00+05	2026-09-04 19:00:00+05
55	78	18	Almaty, Street 8, House 28	delivered	2026-09-11 04:20:00+05	2026-09-11 04:55:00+05	2026-09-11 04:00:00+05
56	28	8	Almaty, Street 8, House 28	delivered	2026-09-04 22:20:00+05	2026-09-04 22:55:00+05	2026-09-04 22:00:00+05
57	79	19	Almaty, Street 9, House 29	delivered	2026-09-11 07:20:00+05	2026-09-11 07:55:00+05	2026-09-11 07:00:00+05
58	29	9	Almaty, Street 9, House 29	delivered	2026-09-05 01:20:00+05	2026-09-05 01:55:00+05	2026-09-05 01:00:00+05
59	80	20	Almaty, Street 10, House 30	delivered	2026-09-11 10:20:00+05	2026-09-11 10:55:00+05	2026-09-11 10:00:00+05
60	30	10	Almaty, Street 10, House 30	delivered	2026-09-05 04:20:00+05	2026-09-05 04:55:00+05	2026-09-05 04:00:00+05
61	81	1	Almaty, Street 11, House 31	cancelled	\N	\N	2026-09-11 13:00:00+05
62	31	11	Almaty, Street 11, House 31	delivered	2026-09-05 07:20:00+05	2026-09-05 07:55:00+05	2026-09-05 07:00:00+05
63	82	2	Almaty, Street 12, House 32	cancelled	\N	\N	2026-09-11 16:00:00+05
64	32	12	Almaty, Street 12, House 32	delivered	2026-09-05 10:20:00+05	2026-09-05 10:55:00+05	2026-09-05 10:00:00+05
65	83	3	Almaty, Street 13, House 33	cancelled	\N	\N	2026-09-11 19:00:00+05
66	33	13	Almaty, Street 13, House 33	delivered	2026-09-05 13:20:00+05	2026-09-05 13:55:00+05	2026-09-05 13:00:00+05
67	84	4	Almaty, Street 14, House 34	cancelled	\N	\N	2026-09-11 22:00:00+05
68	34	14	Almaty, Street 14, House 34	delivered	2026-09-05 16:20:00+05	2026-09-05 16:55:00+05	2026-09-05 16:00:00+05
69	85	5	Almaty, Street 15, House 35	cancelled	\N	\N	2026-09-12 01:00:00+05
70	35	15	Almaty, Street 15, House 35	delivered	2026-09-05 19:20:00+05	2026-09-05 19:55:00+05	2026-09-05 19:00:00+05
71	86	6	Almaty, Street 16, House 36	cancelled	\N	\N	2026-09-12 04:00:00+05
72	36	16	Almaty, Street 16, House 36	delivered	2026-09-05 22:20:00+05	2026-09-05 22:55:00+05	2026-09-05 22:00:00+05
73	87	7	Almaty, Street 17, House 37	cancelled	\N	\N	2026-09-12 07:00:00+05
74	37	17	Almaty, Street 17, House 37	delivered	2026-09-06 01:20:00+05	2026-09-06 01:55:00+05	2026-09-06 01:00:00+05
75	88	8	Almaty, Street 18, House 38	cancelled	\N	\N	2026-09-12 10:00:00+05
76	38	18	Almaty, Street 18, House 38	delivered	2026-09-06 04:20:00+05	2026-09-06 04:55:00+05	2026-09-06 04:00:00+05
77	89	9	Almaty, Street 19, House 39	cancelled	\N	\N	2026-09-12 13:00:00+05
78	39	19	Almaty, Street 19, House 39	delivered	2026-09-06 07:20:00+05	2026-09-06 07:55:00+05	2026-09-06 07:00:00+05
79	90	10	Almaty, Street 20, House 40	cancelled	\N	\N	2026-09-12 16:00:00+05
80	40	20	Almaty, Street 20, House 40	delivered	2026-09-06 10:20:00+05	2026-09-06 10:55:00+05	2026-09-06 10:00:00+05
81	91	11	Almaty, Street 1, House 41	on_the_way	2026-09-12 19:20:00+05	\N	2026-09-12 19:00:00+05
82	41	1	Almaty, Street 1, House 41	delivered	2026-09-06 13:20:00+05	2026-09-06 13:55:00+05	2026-09-06 13:00:00+05
83	92	12	Almaty, Street 2, House 42	on_the_way	2026-09-12 22:20:00+05	\N	2026-09-12 22:00:00+05
84	42	2	Almaty, Street 2, House 42	delivered	2026-09-06 16:20:00+05	2026-09-06 16:55:00+05	2026-09-06 16:00:00+05
85	93	13	Almaty, Street 3, House 43	on_the_way	2026-09-13 01:20:00+05	\N	2026-09-13 01:00:00+05
86	43	3	Almaty, Street 3, House 43	delivered	2026-09-06 19:20:00+05	2026-09-06 19:55:00+05	2026-09-06 19:00:00+05
87	94	14	Almaty, Street 4, House 44	on_the_way	2026-09-13 04:20:00+05	\N	2026-09-13 04:00:00+05
88	44	4	Almaty, Street 4, House 44	delivered	2026-09-06 22:20:00+05	2026-09-06 22:55:00+05	2026-09-06 22:00:00+05
89	95	15	Almaty, Street 5, House 45	on_the_way	2026-09-13 07:20:00+05	\N	2026-09-13 07:00:00+05
90	45	5	Almaty, Street 5, House 45	delivered	2026-09-07 01:20:00+05	2026-09-07 01:55:00+05	2026-09-07 01:00:00+05
91	96	16	Almaty, Street 6, House 46	on_the_way	2026-09-13 10:20:00+05	\N	2026-09-13 10:00:00+05
92	46	6	Almaty, Street 6, House 46	delivered	2026-09-07 04:20:00+05	2026-09-07 04:55:00+05	2026-09-07 04:00:00+05
93	97	17	Almaty, Street 7, House 47	on_the_way	2026-09-13 13:20:00+05	\N	2026-09-13 13:00:00+05
94	47	7	Almaty, Street 7, House 47	delivered	2026-09-07 07:20:00+05	2026-09-07 07:55:00+05	2026-09-07 07:00:00+05
95	98	18	Almaty, Street 8, House 48	on_the_way	2026-09-13 16:20:00+05	\N	2026-09-13 16:00:00+05
96	48	8	Almaty, Street 8, House 48	delivered	2026-09-07 10:20:00+05	2026-09-07 10:55:00+05	2026-09-07 10:00:00+05
97	99	19	Almaty, Street 9, House 49	on_the_way	2026-09-13 19:20:00+05	\N	2026-09-13 19:00:00+05
98	49	9	Almaty, Street 9, House 49	delivered	2026-09-07 13:20:00+05	2026-09-07 13:55:00+05	2026-09-07 13:00:00+05
99	100	20	Almaty, Street 10, House 50	on_the_way	2026-09-13 22:20:00+05	\N	2026-09-13 22:00:00+05
100	50	10	Almaty, Street 10, House 50	delivered	2026-09-07 16:20:00+05	2026-09-07 16:55:00+05	2026-09-07 16:00:00+05
\.


--
-- Data for Name: dish; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.dish (dish_id, restaurant_id, name, description, price, is_available, created_at) FROM stdin;
1	1	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	1650.00	t	2026-10-05 12:57:06.38118+05
2	1	Margherita	Pizza from Dodo Pizza. Price is sample data.	1725.00	t	2026-10-05 12:57:06.38118+05
3	1	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	1800.00	t	2026-10-05 12:57:06.38118+05
4	1	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	1875.00	t	2026-10-05 12:57:06.38118+05
5	1	Carbonara	Pizza from Dodo Pizza. Price is sample data.	1950.00	t	2026-10-05 12:57:06.38118+05
6	2	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	2025.00	t	2026-10-05 12:57:06.38118+05
7	2	Margherita	Pizza from Dodo Pizza. Price is sample data.	2100.00	t	2026-10-05 12:57:06.38118+05
8	2	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	2175.00	t	2026-10-05 12:57:06.38118+05
9	2	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	2250.00	t	2026-10-05 12:57:06.38118+05
10	2	Carbonara	Pizza from Dodo Pizza. Price is sample data.	2325.00	t	2026-10-05 12:57:06.38118+05
11	3	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	2400.00	t	2026-10-05 12:57:06.38118+05
12	3	Margherita	Pizza from Dodo Pizza. Price is sample data.	2475.00	t	2026-10-05 12:57:06.38118+05
13	3	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	2550.00	t	2026-10-05 12:57:06.38118+05
14	3	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	2625.00	t	2026-10-05 12:57:06.38118+05
15	3	Carbonara	Pizza from Dodo Pizza. Price is sample data.	2700.00	t	2026-10-05 12:57:06.38118+05
16	4	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	2775.00	t	2026-10-05 12:57:06.38118+05
17	4	Margherita	Pizza from Dodo Pizza. Price is sample data.	2850.00	t	2026-10-05 12:57:06.38118+05
18	4	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	2925.00	t	2026-10-05 12:57:06.38118+05
19	4	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	3000.00	t	2026-10-05 12:57:06.38118+05
20	4	Carbonara	Pizza from Dodo Pizza. Price is sample data.	3075.00	t	2026-10-05 12:57:06.38118+05
21	5	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	3150.00	t	2026-10-05 12:57:06.38118+05
22	5	Margherita	Pizza from Dodo Pizza. Price is sample data.	3225.00	t	2026-10-05 12:57:06.38118+05
23	5	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	3300.00	t	2026-10-05 12:57:06.38118+05
24	5	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	3375.00	t	2026-10-05 12:57:06.38118+05
25	5	Carbonara	Pizza from Dodo Pizza. Price is sample data.	3450.00	t	2026-10-05 12:57:06.38118+05
26	6	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	3525.00	t	2026-10-05 12:57:06.38118+05
27	6	Margherita	Pizza from Dodo Pizza. Price is sample data.	3600.00	t	2026-10-05 12:57:06.38118+05
28	6	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	3675.00	t	2026-10-05 12:57:06.38118+05
29	6	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	3750.00	t	2026-10-05 12:57:06.38118+05
30	6	Carbonara	Pizza from Dodo Pizza. Price is sample data.	3825.00	t	2026-10-05 12:57:06.38118+05
31	7	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	3900.00	t	2026-10-05 12:57:06.38118+05
32	7	Margherita	Pizza from Dodo Pizza. Price is sample data.	3975.00	t	2026-10-05 12:57:06.38118+05
33	7	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	4050.00	t	2026-10-05 12:57:06.38118+05
34	7	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	4125.00	t	2026-10-05 12:57:06.38118+05
35	7	Carbonara	Pizza from Dodo Pizza. Price is sample data.	4200.00	t	2026-10-05 12:57:06.38118+05
36	8	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	4275.00	t	2026-10-05 12:57:06.38118+05
37	8	Margherita	Pizza from Dodo Pizza. Price is sample data.	4350.00	t	2026-10-05 12:57:06.38118+05
38	8	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	4425.00	t	2026-10-05 12:57:06.38118+05
39	8	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	4500.00	t	2026-10-05 12:57:06.38118+05
40	8	Carbonara	Pizza from Dodo Pizza. Price is sample data.	4575.00	t	2026-10-05 12:57:06.38118+05
41	9	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	4650.00	t	2026-10-05 12:57:06.38118+05
42	9	Margherita	Pizza from Dodo Pizza. Price is sample data.	4725.00	t	2026-10-05 12:57:06.38118+05
43	9	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	4800.00	t	2026-10-05 12:57:06.38118+05
44	9	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	4875.00	t	2026-10-05 12:57:06.38118+05
45	9	Carbonara	Pizza from Dodo Pizza. Price is sample data.	4950.00	t	2026-10-05 12:57:06.38118+05
46	10	Pepperoni	Pizza from Dodo Pizza. Price is sample data.	5025.00	t	2026-10-05 12:57:06.38118+05
47	10	Margherita	Pizza from Dodo Pizza. Price is sample data.	5100.00	t	2026-10-05 12:57:06.38118+05
48	10	Cheese Pizza	Pizza from Dodo Pizza. Price is sample data.	5175.00	t	2026-10-05 12:57:06.38118+05
49	10	Four Cheese	Pizza from Dodo Pizza. Price is sample data.	5250.00	t	2026-10-05 12:57:06.38118+05
50	10	Carbonara	Pizza from Dodo Pizza. Price is sample data.	5325.00	t	2026-10-05 12:57:06.38118+05
\.


--
-- Data for Name: dish_category; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.dish_category (dish_id, category_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	1
12	2
13	3
14	4
15	5
16	6
17	7
18	8
19	9
20	10
21	1
22	2
23	3
24	4
25	5
26	6
27	7
28	8
29	9
30	10
31	1
32	2
33	3
34	4
35	5
36	6
37	7
38	8
39	9
40	10
41	1
42	2
43	3
44	4
45	5
46	6
47	7
48	8
49	9
50	10
1	3
2	4
3	5
4	6
5	7
6	8
7	9
8	10
9	1
10	2
\.


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.order_item (order_item_id, order_id, dish_id, quantity, unit_price) FROM stdin;
1	1	1	3	1650.00
2	1	2	1	1725.00
3	2	6	1	2025.00
4	2	7	2	2100.00
5	3	11	2	2400.00
6	3	12	3	2475.00
7	4	16	3	2775.00
8	4	17	1	2850.00
9	5	21	1	3150.00
10	5	22	2	3225.00
11	6	26	2	3525.00
12	6	27	3	3600.00
13	7	31	3	3900.00
14	7	32	1	3975.00
15	8	36	1	4275.00
16	8	37	2	4350.00
17	9	41	2	4650.00
18	9	42	3	4725.00
19	10	46	3	5025.00
20	10	47	1	5100.00
21	11	1	1	1650.00
22	11	2	2	1725.00
23	12	6	2	2025.00
24	12	7	3	2100.00
25	13	11	3	2400.00
26	13	12	1	2475.00
27	14	16	1	2775.00
28	14	17	2	2850.00
29	15	21	2	3150.00
30	15	22	3	3225.00
31	16	26	3	3525.00
32	16	27	1	3600.00
33	17	31	1	3900.00
34	17	32	2	3975.00
35	18	36	2	4275.00
36	18	37	3	4350.00
37	19	41	3	4650.00
38	19	42	1	4725.00
39	20	46	1	5025.00
40	20	47	2	5100.00
41	21	1	2	1650.00
42	21	2	3	1725.00
43	22	6	3	2025.00
44	22	7	1	2100.00
45	23	11	1	2400.00
46	23	12	2	2475.00
47	24	16	2	2775.00
48	24	17	3	2850.00
49	25	21	3	3150.00
50	25	22	1	3225.00
51	26	26	1	3525.00
52	26	27	2	3600.00
53	27	31	2	3900.00
54	27	32	3	3975.00
55	28	36	3	4275.00
56	28	37	1	4350.00
57	29	41	1	4650.00
58	29	42	2	4725.00
59	30	46	2	5025.00
60	30	47	3	5100.00
61	31	1	3	1650.00
62	31	2	1	1725.00
63	32	6	1	2025.00
64	32	7	2	2100.00
65	33	11	2	2400.00
66	33	12	3	2475.00
67	34	16	3	2775.00
68	34	17	1	2850.00
69	35	21	1	3150.00
70	35	22	2	3225.00
71	36	26	2	3525.00
72	36	27	3	3600.00
73	37	31	3	3900.00
74	37	32	1	3975.00
75	38	36	1	4275.00
76	38	37	2	4350.00
77	39	41	2	4650.00
78	39	42	3	4725.00
79	40	46	3	5025.00
80	40	47	1	5100.00
81	41	1	1	1650.00
82	41	2	2	1725.00
83	42	6	2	2025.00
84	42	7	3	2100.00
85	43	11	3	2400.00
86	43	12	1	2475.00
87	44	16	1	2775.00
88	44	17	2	2850.00
89	45	21	2	3150.00
90	45	22	3	3225.00
91	46	26	3	3525.00
92	46	27	1	3600.00
93	47	31	1	3900.00
94	47	32	2	3975.00
95	48	36	2	4275.00
96	48	37	3	4350.00
97	49	41	3	4650.00
98	49	42	1	4725.00
99	50	46	1	5025.00
100	50	47	2	5100.00
101	51	1	2	1650.00
102	51	2	3	1725.00
103	52	6	3	2025.00
104	52	7	1	2100.00
105	53	11	1	2400.00
106	53	12	2	2475.00
107	54	16	2	2775.00
108	54	17	3	2850.00
109	55	21	3	3150.00
110	55	22	1	3225.00
111	56	26	1	3525.00
112	56	27	2	3600.00
113	57	31	2	3900.00
114	57	32	3	3975.00
115	58	36	3	4275.00
116	58	37	1	4350.00
117	59	41	1	4650.00
118	59	42	2	4725.00
119	60	46	2	5025.00
120	60	47	3	5100.00
121	61	1	3	1650.00
122	61	2	1	1725.00
123	62	6	1	2025.00
124	62	7	2	2100.00
125	63	11	2	2400.00
126	63	12	3	2475.00
127	64	16	3	2775.00
128	64	17	1	2850.00
129	65	21	1	3150.00
130	65	22	2	3225.00
131	66	26	2	3525.00
132	66	27	3	3600.00
133	67	31	3	3900.00
134	67	32	1	3975.00
135	68	36	1	4275.00
136	68	37	2	4350.00
137	69	41	2	4650.00
138	69	42	3	4725.00
139	70	46	3	5025.00
140	70	47	1	5100.00
141	71	1	1	1650.00
142	71	2	2	1725.00
143	72	6	2	2025.00
144	72	7	3	2100.00
145	73	11	3	2400.00
146	73	12	1	2475.00
147	74	16	1	2775.00
148	74	17	2	2850.00
149	75	21	2	3150.00
150	75	22	3	3225.00
151	76	26	3	3525.00
152	76	27	1	3600.00
153	77	31	1	3900.00
154	77	32	2	3975.00
155	78	36	2	4275.00
156	78	37	3	4350.00
157	79	41	3	4650.00
158	79	42	1	4725.00
159	80	46	1	5025.00
160	80	47	2	5100.00
161	81	1	2	1650.00
162	81	2	3	1725.00
163	82	6	3	2025.00
164	82	7	1	2100.00
165	83	11	1	2400.00
166	83	12	2	2475.00
167	84	16	2	2775.00
168	84	17	3	2850.00
169	85	21	3	3150.00
170	85	22	1	3225.00
171	86	26	1	3525.00
172	86	27	2	3600.00
173	87	31	2	3900.00
174	87	32	3	3975.00
175	88	36	3	4275.00
176	88	37	1	4350.00
177	89	41	1	4650.00
178	89	42	2	4725.00
179	90	46	2	5025.00
180	90	47	3	5100.00
181	91	1	3	1650.00
182	91	2	1	1725.00
183	92	6	1	2025.00
184	92	7	2	2100.00
185	93	11	2	2400.00
186	93	12	3	2475.00
187	94	16	3	2775.00
188	94	17	1	2850.00
189	95	21	1	3150.00
190	95	22	2	3225.00
191	96	26	2	3525.00
192	96	27	3	3600.00
193	97	31	3	3900.00
194	97	32	1	3975.00
195	98	36	1	4275.00
196	98	37	2	4350.00
197	99	41	2	4650.00
198	99	42	3	4725.00
199	100	46	3	5025.00
200	100	47	1	5100.00
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.payment (payment_id, order_id, payment_method, payment_status, amount, paid_at, created_at) FROM stdin;
1	1	card	paid	7175.00	2026-09-01 13:05:00+05	2026-09-01 13:00:00+05
2	2	cash	paid	6725.00	2026-09-01 16:05:00+05	2026-09-01 16:00:00+05
3	3	kaspi	paid	12725.00	2026-09-01 19:05:00+05	2026-09-01 19:00:00+05
4	4	card	paid	11675.00	2026-09-01 22:05:00+05	2026-09-01 22:00:00+05
5	5	cash	paid	10100.00	2026-09-02 01:05:00+05	2026-09-02 01:00:00+05
6	6	kaspi	paid	18350.00	2026-09-02 04:05:00+05	2026-09-02 04:00:00+05
7	7	card	paid	16175.00	2026-09-02 07:05:00+05	2026-09-02 07:00:00+05
8	8	cash	paid	13475.00	2026-09-02 10:05:00+05	2026-09-02 10:00:00+05
9	9	kaspi	paid	23975.00	2026-09-02 13:05:00+05	2026-09-02 13:00:00+05
10	10	card	paid	20675.00	2026-09-02 16:05:00+05	2026-09-02 16:00:00+05
11	11	cash	paid	5600.00	2026-09-02 19:05:00+05	2026-09-02 19:00:00+05
12	12	kaspi	paid	10850.00	2026-09-02 22:05:00+05	2026-09-02 22:00:00+05
13	13	card	paid	10175.00	2026-09-03 01:05:00+05	2026-09-03 01:00:00+05
14	14	cash	paid	8975.00	2026-09-03 04:05:00+05	2026-09-03 04:00:00+05
15	15	kaspi	paid	16475.00	2026-09-03 07:05:00+05	2026-09-03 07:00:00+05
16	16	card	paid	14675.00	2026-09-03 10:05:00+05	2026-09-03 10:00:00+05
17	17	cash	paid	12350.00	2026-09-03 13:05:00+05	2026-09-03 13:00:00+05
18	18	kaspi	paid	22100.00	2026-09-03 16:05:00+05	2026-09-03 16:00:00+05
19	19	card	paid	19175.00	2026-09-03 19:05:00+05	2026-09-03 19:00:00+05
20	20	cash	paid	15725.00	2026-09-03 22:05:00+05	2026-09-03 22:00:00+05
21	21	kaspi	paid	8975.00	2026-09-04 01:05:00+05	2026-09-04 01:00:00+05
22	22	card	paid	8675.00	2026-09-04 04:05:00+05	2026-09-04 04:00:00+05
23	23	cash	paid	7850.00	2026-09-04 07:05:00+05	2026-09-04 07:00:00+05
24	24	kaspi	paid	14600.00	2026-09-04 10:05:00+05	2026-09-04 10:00:00+05
25	25	card	paid	13175.00	2026-09-04 13:05:00+05	2026-09-04 13:00:00+05
26	26	cash	paid	11225.00	2026-09-04 16:05:00+05	2026-09-04 16:00:00+05
27	27	kaspi	paid	20225.00	2026-09-04 19:05:00+05	2026-09-04 19:00:00+05
28	28	card	paid	17675.00	2026-09-04 22:05:00+05	2026-09-04 22:00:00+05
29	29	cash	paid	14600.00	2026-09-05 01:05:00+05	2026-09-05 01:00:00+05
30	30	kaspi	paid	25850.00	2026-09-05 04:05:00+05	2026-09-05 04:00:00+05
31	31	card	paid	7175.00	2026-09-05 07:05:00+05	2026-09-05 07:00:00+05
32	32	cash	paid	6725.00	2026-09-05 10:05:00+05	2026-09-05 10:00:00+05
33	33	kaspi	paid	12725.00	2026-09-05 13:05:00+05	2026-09-05 13:00:00+05
34	34	card	paid	11675.00	2026-09-05 16:05:00+05	2026-09-05 16:00:00+05
35	35	cash	paid	10100.00	2026-09-05 19:05:00+05	2026-09-05 19:00:00+05
36	36	kaspi	paid	18350.00	2026-09-05 22:05:00+05	2026-09-05 22:00:00+05
37	37	card	paid	16175.00	2026-09-06 01:05:00+05	2026-09-06 01:00:00+05
38	38	cash	paid	13475.00	2026-09-06 04:05:00+05	2026-09-06 04:00:00+05
39	39	kaspi	paid	23975.00	2026-09-06 07:05:00+05	2026-09-06 07:00:00+05
40	40	card	paid	20675.00	2026-09-06 10:05:00+05	2026-09-06 10:00:00+05
41	41	cash	paid	5600.00	2026-09-06 13:05:00+05	2026-09-06 13:00:00+05
42	42	kaspi	paid	10850.00	2026-09-06 16:05:00+05	2026-09-06 16:00:00+05
43	43	card	paid	10175.00	2026-09-06 19:05:00+05	2026-09-06 19:00:00+05
44	44	cash	paid	8975.00	2026-09-06 22:05:00+05	2026-09-06 22:00:00+05
45	45	kaspi	paid	16475.00	2026-09-07 01:05:00+05	2026-09-07 01:00:00+05
46	46	card	paid	14675.00	2026-09-07 04:05:00+05	2026-09-07 04:00:00+05
47	47	cash	paid	12350.00	2026-09-07 07:05:00+05	2026-09-07 07:00:00+05
48	48	kaspi	paid	22100.00	2026-09-07 10:05:00+05	2026-09-07 10:00:00+05
49	49	card	paid	19175.00	2026-09-07 13:05:00+05	2026-09-07 13:00:00+05
50	50	cash	paid	15725.00	2026-09-07 16:05:00+05	2026-09-07 16:00:00+05
51	51	kaspi	paid	8975.00	2026-09-07 19:05:00+05	2026-09-07 19:00:00+05
52	52	card	paid	8675.00	2026-09-07 22:05:00+05	2026-09-07 22:00:00+05
53	53	cash	paid	7850.00	2026-09-08 01:05:00+05	2026-09-08 01:00:00+05
54	54	kaspi	paid	14600.00	2026-09-08 04:05:00+05	2026-09-08 04:00:00+05
55	55	card	paid	13175.00	2026-09-08 07:05:00+05	2026-09-08 07:00:00+05
56	56	cash	paid	11225.00	2026-09-08 10:05:00+05	2026-09-08 10:00:00+05
57	57	kaspi	paid	20225.00	2026-09-08 13:05:00+05	2026-09-08 13:00:00+05
58	58	card	paid	17675.00	2026-09-08 16:05:00+05	2026-09-08 16:00:00+05
59	59	cash	paid	14600.00	2026-09-08 19:05:00+05	2026-09-08 19:00:00+05
60	60	kaspi	paid	25850.00	2026-09-08 22:05:00+05	2026-09-08 22:00:00+05
61	61	card	paid	7175.00	2026-09-09 01:05:00+05	2026-09-09 01:00:00+05
62	62	cash	paid	6725.00	2026-09-09 04:05:00+05	2026-09-09 04:00:00+05
63	63	kaspi	paid	12725.00	2026-09-09 07:05:00+05	2026-09-09 07:00:00+05
64	64	card	paid	11675.00	2026-09-09 10:05:00+05	2026-09-09 10:00:00+05
65	65	cash	paid	10100.00	2026-09-09 13:05:00+05	2026-09-09 13:00:00+05
66	66	kaspi	paid	18350.00	2026-09-09 16:05:00+05	2026-09-09 16:00:00+05
67	67	card	paid	16175.00	2026-09-09 19:05:00+05	2026-09-09 19:00:00+05
68	68	cash	paid	13475.00	2026-09-09 22:05:00+05	2026-09-09 22:00:00+05
69	69	kaspi	paid	23975.00	2026-09-10 01:05:00+05	2026-09-10 01:00:00+05
70	70	card	paid	20675.00	2026-09-10 04:05:00+05	2026-09-10 04:00:00+05
71	71	cash	paid	5600.00	2026-09-10 07:05:00+05	2026-09-10 07:00:00+05
72	72	kaspi	paid	10850.00	2026-09-10 10:05:00+05	2026-09-10 10:00:00+05
73	73	card	paid	10175.00	2026-09-10 13:05:00+05	2026-09-10 13:00:00+05
74	74	cash	paid	8975.00	2026-09-10 16:05:00+05	2026-09-10 16:00:00+05
75	75	kaspi	paid	16475.00	2026-09-10 19:05:00+05	2026-09-10 19:00:00+05
76	76	card	paid	14675.00	2026-09-10 22:05:00+05	2026-09-10 22:00:00+05
77	77	cash	paid	12350.00	2026-09-11 01:05:00+05	2026-09-11 01:00:00+05
78	78	kaspi	paid	22100.00	2026-09-11 04:05:00+05	2026-09-11 04:00:00+05
79	79	card	paid	19175.00	2026-09-11 07:05:00+05	2026-09-11 07:00:00+05
80	80	cash	paid	15725.00	2026-09-11 10:05:00+05	2026-09-11 10:00:00+05
81	81	kaspi	refunded	8975.00	2026-09-11 13:05:00+05	2026-09-11 13:00:00+05
82	82	card	refunded	8675.00	2026-09-11 16:05:00+05	2026-09-11 16:00:00+05
83	83	cash	refunded	7850.00	2026-09-11 19:05:00+05	2026-09-11 19:00:00+05
84	84	kaspi	refunded	14600.00	2026-09-11 22:05:00+05	2026-09-11 22:00:00+05
85	85	card	refunded	13175.00	2026-09-12 01:05:00+05	2026-09-12 01:00:00+05
86	86	cash	refunded	11225.00	2026-09-12 04:05:00+05	2026-09-12 04:00:00+05
87	87	kaspi	refunded	20225.00	2026-09-12 07:05:00+05	2026-09-12 07:00:00+05
88	88	card	refunded	17675.00	2026-09-12 10:05:00+05	2026-09-12 10:00:00+05
89	89	cash	refunded	14600.00	2026-09-12 13:05:00+05	2026-09-12 13:00:00+05
90	90	kaspi	refunded	25850.00	2026-09-12 16:05:00+05	2026-09-12 16:00:00+05
91	91	card	pending	7175.00	\N	2026-09-12 19:00:00+05
92	92	cash	pending	6725.00	\N	2026-09-12 22:00:00+05
93	93	kaspi	pending	12725.00	\N	2026-09-13 01:00:00+05
94	94	card	pending	11675.00	\N	2026-09-13 04:00:00+05
95	95	cash	pending	10100.00	\N	2026-09-13 07:00:00+05
96	96	kaspi	pending	18350.00	\N	2026-09-13 10:00:00+05
97	97	card	pending	16175.00	\N	2026-09-13 13:00:00+05
98	98	cash	pending	13475.00	\N	2026-09-13 16:00:00+05
99	99	kaspi	pending	23975.00	\N	2026-09-13 19:00:00+05
100	100	card	pending	20675.00	\N	2026-09-13 22:00:00+05
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: food_delivery; Owner: -
--

COPY food_delivery.review (review_id, order_id, customer_id, restaurant_id, rating, comment, created_at) FROM stdin;
1	1	1	1	3	Good food and normal delivery time	2026-09-01 15:00:00+05
2	2	2	2	4	Everything was good	2026-09-01 18:00:00+05
3	3	3	3	5	Excellent food and fast delivery	2026-09-01 21:00:00+05
4	4	4	4	3	Good food and normal delivery time	2026-09-02 00:00:00+05
5	5	5	5	4	Everything was good	2026-09-02 03:00:00+05
6	6	6	6	5	Excellent food and fast delivery	2026-09-02 06:00:00+05
7	7	7	7	3	Good food and normal delivery time	2026-09-02 09:00:00+05
8	8	8	8	4	Everything was good	2026-09-02 12:00:00+05
9	9	9	9	5	Excellent food and fast delivery	2026-09-02 15:00:00+05
10	10	10	10	3	Good food and normal delivery time	2026-09-02 18:00:00+05
11	11	11	1	4	Everything was good	2026-09-02 21:00:00+05
12	12	12	2	5	Excellent food and fast delivery	2026-09-03 00:00:00+05
13	13	13	3	3	Good food and normal delivery time	2026-09-03 03:00:00+05
14	14	14	4	4	Everything was good	2026-09-03 06:00:00+05
15	15	15	5	5	Excellent food and fast delivery	2026-09-03 09:00:00+05
16	16	16	6	3	Good food and normal delivery time	2026-09-03 12:00:00+05
17	17	17	7	4	Everything was good	2026-09-03 15:00:00+05
18	18	18	8	5	Excellent food and fast delivery	2026-09-03 18:00:00+05
19	19	19	9	3	Good food and normal delivery time	2026-09-03 21:00:00+05
20	20	20	10	4	Everything was good	2026-09-04 00:00:00+05
21	21	21	1	5	Excellent food and fast delivery	2026-09-04 03:00:00+05
22	22	22	2	3	Good food and normal delivery time	2026-09-04 06:00:00+05
23	23	23	3	4	Everything was good	2026-09-04 09:00:00+05
24	24	24	4	5	Excellent food and fast delivery	2026-09-04 12:00:00+05
25	25	25	5	3	Good food and normal delivery time	2026-09-04 15:00:00+05
26	26	26	6	4	Everything was good	2026-09-04 18:00:00+05
27	27	27	7	5	Excellent food and fast delivery	2026-09-04 21:00:00+05
28	28	28	8	3	Good food and normal delivery time	2026-09-05 00:00:00+05
29	29	29	9	4	Everything was good	2026-09-05 03:00:00+05
30	30	30	10	5	Excellent food and fast delivery	2026-09-05 06:00:00+05
31	31	31	1	3	Good food and normal delivery time	2026-09-05 09:00:00+05
32	32	32	2	4	Everything was good	2026-09-05 12:00:00+05
33	33	33	3	5	Excellent food and fast delivery	2026-09-05 15:00:00+05
34	34	34	4	3	Good food and normal delivery time	2026-09-05 18:00:00+05
35	35	35	5	4	Everything was good	2026-09-05 21:00:00+05
36	36	36	6	5	Excellent food and fast delivery	2026-09-06 00:00:00+05
37	37	37	7	3	Good food and normal delivery time	2026-09-06 03:00:00+05
38	38	38	8	4	Everything was good	2026-09-06 06:00:00+05
39	39	39	9	5	Excellent food and fast delivery	2026-09-06 09:00:00+05
40	40	40	10	3	Good food and normal delivery time	2026-09-06 12:00:00+05
41	41	41	1	4	Everything was good	2026-09-06 15:00:00+05
42	42	42	2	5	Excellent food and fast delivery	2026-09-06 18:00:00+05
43	43	43	3	3	Good food and normal delivery time	2026-09-06 21:00:00+05
44	44	44	4	4	Everything was good	2026-09-07 00:00:00+05
45	45	45	5	5	Excellent food and fast delivery	2026-09-07 03:00:00+05
46	46	46	6	3	Good food and normal delivery time	2026-09-07 06:00:00+05
47	47	47	7	4	Everything was good	2026-09-07 09:00:00+05
48	48	48	8	5	Excellent food and fast delivery	2026-09-07 12:00:00+05
49	49	49	9	3	Good food and normal delivery time	2026-09-07 15:00:00+05
50	50	50	10	4	Everything was good	2026-09-07 18:00:00+05
\.


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.category_category_id_seq', 10, true);


--
-- Name: courier_courier_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.courier_courier_id_seq', 20, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.customer_customer_id_seq', 50, true);


--
-- Name: delivery_delivery_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.delivery_delivery_id_seq', 100, true);


--
-- Name: dish_dish_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.dish_dish_id_seq', 50, true);


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.order_item_order_item_id_seq', 200, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.orders_order_id_seq', 100, true);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.payment_payment_id_seq', 100, true);


--
-- Name: restaurant_restaurant_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.restaurant_restaurant_id_seq', 10, true);


--
-- Name: review_review_id_seq; Type: SEQUENCE SET; Schema: food_delivery; Owner: -
--

SELECT pg_catalog.setval('food_delivery.review_review_id_seq', 50, true);


--
-- PostgreSQL database dump complete
--

\unrestrict 07Cr0yNCkadRSORh5DKjenz3T3p6wx9PC7HXa6pmWMmmuCYXMdbGXVxr7zIoc2A

