package com.example.affirmation.practice.labNavigation

import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun CupcakeAppBar(
    canNavigateBack: Boolean,
    navigateUp: () -> Unit,
    modifier: Modifier = Modifier
) {
    TopAppBar(
        title = { Text("Cupcake") },
        backgroundColor = MaterialTheme.colors.primary,
        navigationIcon = {
            if (canNavigateBack) {
                IconButton(onClick = navigateUp) {
                    Icon(
                        imageVector = Icons.Filled.ArrowBack,
                        contentDescription = "Back Button"
                    )
                }
            }
        }
    )
}

//@Composable
//fun CupcakeApp(
//    viewModel: OrderViewModel = viewModel(),
//    navController: NavHostController = rememberNavController()
//) {
//
//    Scaffold(
//        topBar = {
//            CupcakeAppBar(
//                canNavigateBack = false,
//                navigateUp = { /* TODO: implement back navigation */ }
//            )
//        }
//    ) { innerPadding ->
//        val uiState by viewModel.uiState.collectAsState()
//
//    }
//}