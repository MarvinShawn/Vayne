import React from 'react'
import {View, Text, StyleSheet} from 'react-native'

const styles = StyleSheet.create({
    container:{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FCFCFC',
    },
    buz_a_title:{
        fontSize:20,
        textAlign:'center',
    }
})
const App = () => {
    return (
        <View style={styles.container}>
            <Text style={styles.buz_a_title}>我是业务1</Text>
        </View>
    )
}


export default App