import React from 'react'
import {View, Text, StyleSheet} from 'react-native'

const styles = StyleSheet.create({
    container:{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FCFCFC',
    },
    buz_c_title:{
        fontSize:20,
        textAlign:'center',
    }
})
const App = () => {
    return (
        <View style={styles.container}>
            <Text style={styles.buz_c_title}>我是业务c</Text>
        </View>
    )
}


export default App
