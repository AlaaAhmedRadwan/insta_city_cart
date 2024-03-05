import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../core/network/api_constant.dart';

abstract class DeleteCartItem extends StatelessWidget {
  const DeleteCartItem({super.key});
  static Future<void> callGraphQLQuery(int amount, int id) async {
    // Define your GraphQL query string with variables
    const String editQuery = '''
    query {
      carts(Function: "Delete") {
        id
        amount
      }
    }
  ''';
    // Create a map containing your variables
    final Map<String, dynamic> variables = {
      'amount': amount,
      'id': id,
    };

    // Create a GraphQL client and execute the query with variables
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(ApiConstant.graphQLEndpoint),
    );

    final QueryOptions options = QueryOptions(
      document: gql(editQuery),
      variables: variables,
    );

    final QueryResult result = await client.query(options);
    // Handle the query result as needed
    if (result.hasException) {
      print('Failed to execute query: ${result.exception.toString()}');
    } else {
      print('Query result: ${result.data}');
    }
  }


}
