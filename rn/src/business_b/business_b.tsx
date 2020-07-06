import React from 'react'
import {View, Text, StyleSheet} from 'react-native'

const styles = StyleSheet.create({
    container:{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FCFCFC',
    },
    buz_b_title:{
        fontSize:20,
        textAlign:'center',
    }
})
const App = () => {
    return (
        <View style={styles.container}>
            <Text style={styles.buz_b_title}>我是业务b</Text>
        </View>
    )
}


export default App
