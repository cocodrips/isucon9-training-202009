use `isutrain`;

INSERT INTO distance_fare_master(distance, fare) VALUES (0, 2500);
INSERT INTO distance_fare_master(distance, fare) VALUES (50, 3000);
INSERT INTO distance_fare_master(distance, fare) VALUES (75, 3700);
INSERT INTO distance_fare_master(distance, fare) VALUES (100, 4500);
INSERT INTO distance_fare_master(distance, fare) VALUES (150, 5200);
INSERT INTO distance_fare_master(distance, fare) VALUES (200, 6000);
INSERT INTO distance_fare_master(distance, fare) VALUES (300, 7200);
INSERT INTO distance_fare_master(distance, fare) VALUES (400, 8300);
INSERT INTO distance_fare_master(distance, fare) VALUES (500, 12000);
INSERT INTO distance_fare_master(distance, fare) VALUES (1000, 20000);

create index seat_master_train_class_car_number_index
	on seat_master (train_class, car_number);
create index fare_master_train_class_seat_class_index
	on fare_master (train_class, seat_class);
create index seat_reservations_reservation_id_index
	on seat_reservations (reservation_id);

create index train_master_date_is_nobori_train_class_index
	on train_master (date, is_nobori, train_class);
create index train_master_date_train_class_train_name_index
	on train_master (date, train_class, train_name);
create index train_master_is_nobori_date_index
	on train_master (is_nobori, date);
