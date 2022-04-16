import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:leet_tutur/models/favorite_tutor.dart';
import 'package:leet_tutur/models/requests/tutor_request.dart';
import 'package:leet_tutur/models/responses/tutor_response.dart';
import 'package:leet_tutur/models/row_of_tutor.dart';
import 'package:leet_tutur/models/tutor.dart';
import 'package:leet_tutur/utils/api_utils.dart';
import 'package:logger/logger.dart';

class TutorService {
  final _logger = GetIt.instance.get<Logger>();
  final _dio = GetIt.instance.get<Dio>();

  final tutorDetailResponse = """
  {
    "id": "0356fb75-f10c-4f15-a87c-b7ada058688b",
    "userId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
    "video": "https://sandbox.api.lettutor.com/video/f64bca88-80fb-479d-a9d1-66fd326cfa45video1641245785756.mp4",
    "bio": "Hey, it's me Goku. I am an online English teacher <3",
    "education": "Earth, Vegeta planet",
    "experience": "7 years of English tutor",
    "profession": "English tutor, fighter ",
    "accent": null,
    "targetStudent": "Intermediate",
    "interests": "Fighting",
    "languages": "en,ja",
    "specialties": "business-english,ielts,pet,ket",
    "resume": null,
    "isActivated": true,
    "isNative": null,
    "createdAt": "2021-08-02T14:33:35.013Z",
    "updatedAt": "2022-01-03T21:46:05.400Z",
    "User": {
        "id": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
        "level": "UPPER_INTERMEDIATE",
        "email": "teacher+3@lettutor.com",
        "google": null,
        "facebook": null,
        "apple": null,
        "avatar": "https://sandbox.api.lettutor.com/avatar/f64bca88-80fb-479d-a9d1-66fd326cfa45avatar1641221123090.jpg",
        "name": "Son Goku",
        "country": "VN",
        "phone": "81353180678",
        "language": null,
        "birthday": "1998-10-27",
        "requestPassword": false,
        "isActivated": true,
        "isPhoneActivated": null,
        "requireNote": null,
        "timezone": 7,
        "phoneAuth": null,
        "isPhoneAuthActivated": false,
        "createdAt": "2021-08-02T14:30:27.328Z",
        "updatedAt": "2022-01-23T10:19:08.195Z",
        "deletedAt": null,
        "feedbacks": [
            {
                "id": "67234004-b4f2-4477-8986-55228c0f1bbc",
                "bookingId": "bc19f336-4195-48dd-8847-6aa3b232f671",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": ":))",
                "createdAt": "2022-01-04T10:45:21.746Z",
                "updatedAt": "2022-01-04T10:45:21.746Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "3d389231-edb0-4fa8-907a-94e1fa26cce3",
                "bookingId": "5b37882e-8e8a-43b6-ac41-5da737293f3e",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "Kameyoko",
                "createdAt": "2022-01-04T16:18:33.662Z",
                "updatedAt": "2022-01-04T16:18:33.662Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "2cd77bd7-96ec-4178-887a-4ae92104c57a",
                "bookingId": "005bbc11-6688-4c28-8906-8121bfb1880f",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "Thanks Kakarot =))",
                "createdAt": "2022-01-04T19:07:59.082Z",
                "updatedAt": "2022-01-04T19:07:59.082Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "26561581-8d40-4e61-98e2-18e300f78992",
                "bookingId": "6cdc3ee9-1d8b-4924-8b20-5ef06b95f578",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 0,
                "content": ".....",
                "createdAt": "2022-01-05T04:02:11.412Z",
                "updatedAt": "2022-01-05T04:02:11.412Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "23e1a094-ec90-47a4-8509-f750c7a874e1",
                "bookingId": "5acf82fc-7a94-4a3e-87e1-b31a220720df",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": ":'D",
                "createdAt": "2022-01-05T10:01:55.356Z",
                "updatedAt": "2022-01-05T10:01:55.356Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "8b07dd73-0119-4276-b939-0dbecfaa970f",
                "bookingId": "6fd6a4a1-be92-42a6-ac8c-93d8f082b1c3",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 4,
                "content": "Greatest teacher I have learned !",
                "createdAt": "2022-01-08T01:46:16.220Z",
                "updatedAt": "2022-01-08T01:46:16.220Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "97763999-4ace-448a-9667-9743631a7890",
                "bookingId": "f8656b7b-b14a-4aeb-9d68-8908039335cf",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "nice",
                "createdAt": "2022-01-09T14:24:02.433Z",
                "updatedAt": "2022-01-09T14:24:02.433Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "e301259b-4d57-4711-b0bc-eb9ca9c005ad",
                "bookingId": "ae2f0181-ab1f-43cb-8d89-15733f1e1c35",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "ok goku",
                "createdAt": "2022-01-11T23:18:25.577Z",
                "updatedAt": "2022-01-11T23:18:25.577Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "36900cbe-a87b-4164-a2a3-2d8a0262c4af",
                "bookingId": "4d006b33-6ee2-446b-bc46-51f6b2e46308",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "okkkkkkkkk",
                "createdAt": "2022-01-18T22:40:25.707Z",
                "updatedAt": "2022-01-18T22:40:25.707Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "3671e4eb-8bee-439f-951f-8fba8a2dc2e6",
                "bookingId": "4d006b33-6ee2-446b-bc46-51f6b2e46308",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "hihi",
                "createdAt": "2022-01-19T02:21:42.757Z",
                "updatedAt": "2022-01-19T02:21:42.757Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "e5bba25e-8160-4bf3-8b1f-1ab8cf573e21",
                "bookingId": "a9627575-66f1-4b30-8833-7b964aaf4eec",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 3,
                "content": "Reviewwwww",
                "createdAt": "2022-01-19T09:15:08.646Z",
                "updatedAt": "2022-01-19T09:15:08.646Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "55bac422-ed9a-49eb-a8cd-45eb11bd62e9",
                "bookingId": "a07bf25c-3214-4924-820b-0d4ae96778d6",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "ok ku",
                "createdAt": "2022-01-19T13:23:48.645Z",
                "updatedAt": "2022-01-19T13:23:48.645Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "35e0addc-2efc-47d7-8bfa-62c7c553f4e9",
                "bookingId": "2c00bc9d-aca2-48f7-a320-c47002d7f55d",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "Nice\n",
                "createdAt": "2022-01-19T16:54:25.003Z",
                "updatedAt": "2022-01-19T16:54:25.003Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "0976caad-7cd3-49a6-b0ea-063037266429",
                "bookingId": "040ccf59-783b-4d63-a531-56b26f8d2561",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "😃😃😃",
                "createdAt": "2022-01-19T18:00:34.228Z",
                "updatedAt": "2022-01-19T18:00:34.228Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "47dcdbcd-ec5d-4b34-8c51-ff36e533028c",
                "bookingId": "4d006b33-6ee2-446b-bc46-51f6b2e46308",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "Rat hay",
                "createdAt": "2022-01-19T20:03:30.582Z",
                "updatedAt": "2022-01-19T20:03:30.582Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "a7d5a77d-d129-46d1-9a91-997502f59fd2",
                "bookingId": "c191abc4-47cb-41a3-88d6-d66d3790cfdd",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 0,
                "content": "ok ku",
                "createdAt": "2022-01-20T07:30:58.513Z",
                "updatedAt": "2022-01-20T07:30:58.513Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "6cb7458e-0cfe-49c9-bc6f-c1804c58a910",
                "bookingId": "b9becbd9-ed7f-4d18-bd55-22b112e2ad00",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "",
                "createdAt": "2022-01-20T07:44:48.282Z",
                "updatedAt": "2022-01-20T07:44:48.282Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "243aa17a-e21c-40b4-8e24-553ddaa2a9d0",
                "bookingId": "b9becbd9-ed7f-4d18-bd55-22b112e2ad00",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 5,
                "content": "hihi",
                "createdAt": "2022-01-20T07:46:00.302Z",
                "updatedAt": "2022-01-20T07:46:00.302Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "b3ca978e-827c-4192-8898-cee36d3bab02",
                "bookingId": "b9becbd9-ed7f-4d18-bd55-22b112e2ad00",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 4,
                "content": "very good teacher \n",
                "createdAt": "2022-01-20T09:03:16.908Z",
                "updatedAt": "2022-01-20T09:03:16.908Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "dc606a63-e08e-437d-84f9-8dd38cbb5be5",
                "bookingId": "d706bb42-9625-4cdd-9e57-d1295fa46c51",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 4,
                "content": "this is very good teacher ",
                "createdAt": "2022-01-20T12:12:25.083Z",
                "updatedAt": "2022-01-20T12:12:25.083Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "91168bcc-6a79-4c0f-b8c2-63d4d48313cc",
                "bookingId": "d706bb42-9625-4cdd-9e57-d1295fa46c51",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 4,
                "content": "good",
                "createdAt": "2022-01-20T14:40:56.835Z",
                "updatedAt": "2022-01-20T14:40:56.835Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            },
            {
                "id": "0f243686-6e78-445c-849a-6f5d78d3ab97",
                "bookingId": "0ce840ae-9c9a-444c-8756-bafcd1058cd4",
                "firstId": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                "secondId": "f64bca88-80fb-479d-a9d1-66fd326cfa45",
                "rating": 4,
                "content": "g",
                "createdAt": "2022-01-25T04:45:51.151Z",
                "updatedAt": "2022-01-25T04:45:51.151Z",
                "firstInfo": {
                    "id": "f569c202-7bbf-4620-af77-ecc1419a6b28",
                    "level": "INTERMEDIATE",
                    "email": "student@lettutor.com",
                    "google": null,
                    "facebook": null,
                    "apple": null,
                    "avatar": "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1644828460150.jpg",
                    "name": "Trần Nam",
                    "country": "VN",
                    "phone": "842499996508",
                    "language": "Albanian",
                    "birthday": "1999-06-01",
                    "requestPassword": true,
                    "isActivated": true,
                    "isPhoneActivated": true,
                    "requireNote": null,
                    "timezone": 7,
                    "phoneAuth": null,
                    "isPhoneAuthActivated": false,
                    "createdAt": "2021-10-19T13:08:04.242Z",
                    "updatedAt": "2022-03-21T14:25:20.978Z",
                    "deletedAt": null
                }
            }
        ],
        "courses": []
    },
    "isFavorite": false,
    "avgRating": 4.2272727272727275,
    "price": 50000
}
  """;

  Future<TutorResponse> getTutors({TutorRequest? request}) async {
    var tutorDioRes = await _dio.post(
      "/tutor/search",
      data: request?.toJson(),
    );

    var favoriteTutorDioRes = await _dio.get(
      "/tutor/more",
      queryParameters: {
        "page": 1,
        "perPage": 9,
      },
    );

    var tutorResponse = TutorResponse(
      tutors: RowOfTutor.fromJson(tutorDioRes.data),
      favoriteTutor: (favoriteTutorDioRes.data?["favoriteTutor"] as List)
          .map((e) => FavoriteTutor.fromJson(e))
          .toList(),
    );

    _logger.i("Total tutors found: ${tutorResponse.tutors?.rows?.length}");

    return tutorResponse;
  }

  Future addToFavoriteTutorAsync(String? tutorId) async {
    try {
      await _dio.post(
        "/user/manageFavoriteTutor",
        data: {
          "tutorId": tutorId,
        },
      );
    } on DioError catch (e) {
      _logger.e("Can't add tutor to favorite. ${e.message}");
      rethrow;
    }
  }

  Future<Map<String, String>> getTutorSpecialtiesAsync() async {
    var twoDResponse = await Future.wait(
      [
        _dio.get("/learn-topic"),
        _dio.get("/test-preparation"),
      ],
    );
    var map = twoDResponse
        .map(
          (e) => e.data as List,
        )
        .reduce(
          (value, element) => value..addAll(element),
        )
        .fold(
      <String, String>{},
      (Map<String, String> previousValue, element) => previousValue
        ..putIfAbsent(
          element["key"],
          () => element["name"],
        ),
    );

    return map;
  }

  Future<Tutor> getTutorDetail({String id = "0"}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var response =
        Tutor.fromJson(jsonDecode(tutorDetailResponse.replaceAll("\n", "")));

    _logger.i(
        "Get tutor detail. Name: ${response.user?.name}. Number of feedback: ${response.user?.feedbacks?.length}");

    return response;
  }
}
