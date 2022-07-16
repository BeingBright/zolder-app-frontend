import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/book.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/services/api_controller.dart';

class BookService {
  GetIt getIt = GetIt.instance;

  Future<List<Book>> getBook() async {
    return Book.generateList(await getIt<APIController>().get(
      APIConfiguration.book,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<Book> getBookById(String id) async {
    return Book.fromJson(await getIt<APIController>().get(
      '${APIConfiguration.book}/$id',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<Book> addBook(Book book) async {
    return Book.fromJson(await getIt<APIController>().post(
      APIConfiguration.book,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: book,
    ));
  }

  Future<Book> updateBook(Book book) async {
    return Book.fromJson(await getIt<APIController>().put(
      APIConfiguration.book,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: book,
    ));
  }

  Future removeBook(Book book) async {
    return Book.fromJson(await getIt<APIController>().delete(
      APIConfiguration.book,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: book,
    ));
  }
}
