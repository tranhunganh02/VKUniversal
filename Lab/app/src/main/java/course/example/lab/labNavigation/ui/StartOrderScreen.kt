package com.example.affirmation.practice.labNavigation.ui

import android.util.MutableInt
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.Button
import androidx.compose.material.Scaffold
import androidx.compose.material.SnackbarDefaults
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.affirmation.R

@Composable
fun StartOrderScreen() {
    Scaffold(
        topBar = {
            TopAppBar {
                SnackbarDefaults.primaryActionColor
            }
        }
    ) {
        innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding),
            verticalArrangement = Arrangement.SpaceBetween,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            var numberCake: Int = remember { mutableStateOf(0) }.value

            Box(Modifier.width(150.dp).height(200.dp).padding(top = 10.dp)){
                Image( painter = painterResource(id = R.drawable.cupcake), contentDescription = null, modifier = Modifier.fillMaxSize())
            }
            Box{
                Column {
                    Button(onClick = {
                                     numberCake = 1

                                     },
                        Modifier
                            .fillMaxWidth()
                            .background(Color.Cyan)) {
                        Text(text = "1 Cake")
                    }
                    Button(onClick = {  numberCake = 6 },
                        Modifier
                            .fillMaxWidth()
                            .background(Color.Cyan)) {
                        Text(text = "6 Cake")
                    }
                    Button(onClick = { numberCake = 12 },
                        Modifier
                            .fillMaxWidth()
                            .background(Color.Cyan)) {
                        Text(text = "12 Cake")
                    }
                }
            }
        }
    }
}

@Preview
@Composable
fun Screen1() {
    StartOrderScreen()
}