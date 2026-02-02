import 'package:crunchbox/core/themes/app_theme.dart';
import 'package:crunchbox/features/account/data/datasources/remote_supabase_account_data_source.dart';
import 'package:crunchbox/features/account/data/repositories/account_repository_impl.dart';
import 'package:crunchbox/features/account/domain/repositories/account_repository.dart';
import 'package:crunchbox/features/account/presentation/bloc/account_bloc.dart';
import 'package:crunchbox/features/account/presentation/pages/login_page.dart';
import 'package:crunchbox/features/product/data/datasources/remote_supabase_product_data_source.dart';
import 'package:crunchbox/features/product/data/repositories/product_repository_impl.dart';
import 'package:crunchbox/features/product/domain/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: '${dotenv.env['PROJECT_URL']}',
    anonKey: '${dotenv.env['PUBLIC_API_KEY']}',
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Repository for Account
        RepositoryProvider<AccountRepository>(
          create: (context) => AccountRepositoryImpl(
            RemoteSupabaseAccountDataSourceImpl(supabase),
          ),
        ),
        // Repository for Product
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            RemoteSupabaseProductDataSourceImpl(supabase),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountBloc(
              accountRepository: context.read<AccountRepository>(),
            )..add(AccountInitialCheck()),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
              productRepository: context.read<ProductRepository>(),
            )..add(FetchProductsAndCategories()), // Initial fetch
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crunch Box',
          theme: AppTheme.darkThemeMode,
          home: AuthWrapper(),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountSuccess) {
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
