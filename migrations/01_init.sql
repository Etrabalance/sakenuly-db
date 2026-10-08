--
-- PostgreSQL database dump
--

\restrict frNM45a6P8vV5zNltJDvgtqb8rXyIcHkmUFTg930LxPF1C0BfGkpOVoLNr44Ohe

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
-- Name: food_delivery; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA food_delivery;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.category (
    category_id bigint NOT NULL,
    name text NOT NULL,
    description text
);


--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: courier; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.courier (
    courier_id bigint NOT NULL,
    full_name text NOT NULL,
    phone text NOT NULL,
    transport_type text NOT NULL,
    rating numeric(2,1),
    hire_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT courier_rating_check CHECK (((rating >= (0)::numeric) AND (rating <= (5)::numeric))),
    CONSTRAINT courier_transport_type_check CHECK ((transport_type = ANY (ARRAY['car'::text, 'motorcycle'::text, 'bicycle'::text, 'scooter'::text, 'walking'::text])))
);


--
-- Name: courier_courier_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.courier ALTER COLUMN courier_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.courier_courier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.customer (
    customer_id bigint NOT NULL,
    full_name text NOT NULL,
    phone text NOT NULL,
    email text,
    address text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.customer ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: delivery; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.delivery (
    delivery_id bigint NOT NULL,
    order_id bigint NOT NULL,
    courier_id bigint NOT NULL,
    delivery_address text NOT NULL,
    status text NOT NULL,
    picked_up_at timestamp with time zone,
    delivered_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT delivery_status_check CHECK ((status = ANY (ARRAY['waiting'::text, 'on_the_way'::text, 'delivered'::text, 'cancelled'::text])))
);


--
-- Name: delivery_delivery_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.delivery ALTER COLUMN delivery_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.delivery_delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dish; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.dish (
    dish_id bigint NOT NULL,
    restaurant_id bigint NOT NULL,
    name text NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    is_available boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT dish_price_check CHECK ((price > (0)::numeric))
);


--
-- Name: dish_category; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.dish_category (
    dish_id bigint NOT NULL,
    category_id bigint NOT NULL
);


--
-- Name: dish_dish_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.dish ALTER COLUMN dish_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.dish_dish_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: order_item; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.order_item (
    order_item_id bigint NOT NULL,
    order_id bigint NOT NULL,
    dish_id bigint NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    CONSTRAINT order_item_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_item_unit_price_check CHECK ((unit_price > (0)::numeric))
);


--
-- Name: order_item_order_item_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.order_item ALTER COLUMN order_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.order_item_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: orders; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.orders (
    order_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    restaurant_id bigint NOT NULL,
    status text NOT NULL,
    delivery_fee numeric(8,2) DEFAULT 500 NOT NULL,
    total_amount numeric(10,2) DEFAULT 0 NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT orders_delivery_fee_check CHECK ((delivery_fee >= (0)::numeric)),
    CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY['new'::text, 'preparing'::text, 'on_the_way'::text, 'delivered'::text, 'cancelled'::text]))),
    CONSTRAINT orders_total_amount_check CHECK ((total_amount >= (0)::numeric))
);


--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.orders ALTER COLUMN order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payment; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.payment (
    payment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    payment_method text NOT NULL,
    payment_status text NOT NULL,
    amount numeric(10,2) NOT NULL,
    paid_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT payment_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT payment_payment_method_check CHECK ((payment_method = ANY (ARRAY['cash'::text, 'card'::text, 'kaspi'::text]))),
    CONSTRAINT payment_payment_status_check CHECK ((payment_status = ANY (ARRAY['pending'::text, 'paid'::text, 'refunded'::text, 'failed'::text])))
);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.payment ALTER COLUMN payment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: restaurant; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.restaurant (
    restaurant_id bigint NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    phone text,
    rating numeric(2,1),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT restaurant_rating_check CHECK (((rating >= (0)::numeric) AND (rating <= (5)::numeric)))
);


--
-- Name: restaurant_restaurant_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.restaurant ALTER COLUMN restaurant_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.restaurant_restaurant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: review; Type: TABLE; Schema: food_delivery; Owner: -
--

CREATE TABLE food_delivery.review (
    review_id bigint NOT NULL,
    order_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    restaurant_id bigint NOT NULL,
    rating smallint NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT review_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


--
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: food_delivery; Owner: -
--

ALTER TABLE food_delivery.review ALTER COLUMN review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME food_delivery.review_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: category category_name_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: courier courier_phone_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.courier
    ADD CONSTRAINT courier_phone_key UNIQUE (phone);


--
-- Name: courier courier_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.courier
    ADD CONSTRAINT courier_pkey PRIMARY KEY (courier_id);


--
-- Name: customer customer_email_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.customer
    ADD CONSTRAINT customer_email_key UNIQUE (email);


--
-- Name: customer customer_phone_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.customer
    ADD CONSTRAINT customer_phone_key UNIQUE (phone);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: delivery delivery_order_id_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.delivery
    ADD CONSTRAINT delivery_order_id_key UNIQUE (order_id);


--
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (delivery_id);


--
-- Name: dish_category dish_category_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.dish_category
    ADD CONSTRAINT dish_category_pkey PRIMARY KEY (dish_id, category_id);


--
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- Name: order_item order_item_order_id_dish_id_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.order_item
    ADD CONSTRAINT order_item_order_id_dish_id_key UNIQUE (order_id, dish_id);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payment payment_order_id_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.payment
    ADD CONSTRAINT payment_order_id_key UNIQUE (order_id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- Name: restaurant restaurant_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.restaurant
    ADD CONSTRAINT restaurant_pkey PRIMARY KEY (restaurant_id);


--
-- Name: review review_order_id_key; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.review
    ADD CONSTRAINT review_order_id_key UNIQUE (order_id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- Name: delivery delivery_courier_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.delivery
    ADD CONSTRAINT delivery_courier_id_fkey FOREIGN KEY (courier_id) REFERENCES food_delivery.courier(courier_id);


--
-- Name: delivery delivery_order_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.delivery
    ADD CONSTRAINT delivery_order_id_fkey FOREIGN KEY (order_id) REFERENCES food_delivery.orders(order_id);


--
-- Name: dish_category dish_category_category_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.dish_category
    ADD CONSTRAINT dish_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES food_delivery.category(category_id) ON DELETE CASCADE;


--
-- Name: dish_category dish_category_dish_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.dish_category
    ADD CONSTRAINT dish_category_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES food_delivery.dish(dish_id) ON DELETE CASCADE;


--
-- Name: dish dish_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.dish
    ADD CONSTRAINT dish_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES food_delivery.restaurant(restaurant_id);


--
-- Name: order_item order_item_dish_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.order_item
    ADD CONSTRAINT order_item_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES food_delivery.dish(dish_id);


--
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES food_delivery.orders(order_id) ON DELETE CASCADE;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES food_delivery.customer(customer_id);


--
-- Name: orders orders_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.orders
    ADD CONSTRAINT orders_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES food_delivery.restaurant(restaurant_id);


--
-- Name: payment payment_order_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.payment
    ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES food_delivery.orders(order_id);


--
-- Name: review review_customer_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.review
    ADD CONSTRAINT review_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES food_delivery.customer(customer_id);


--
-- Name: review review_order_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.review
    ADD CONSTRAINT review_order_id_fkey FOREIGN KEY (order_id) REFERENCES food_delivery.orders(order_id);


--
-- Name: review review_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: food_delivery; Owner: -
--

ALTER TABLE ONLY food_delivery.review
    ADD CONSTRAINT review_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES food_delivery.restaurant(restaurant_id);


--
-- PostgreSQL database dump complete
--

\unrestrict frNM45a6P8vV5zNltJDvgtqb8rXyIcHkmUFTg930LxPF1C0BfGkpOVoLNr44Ohe

