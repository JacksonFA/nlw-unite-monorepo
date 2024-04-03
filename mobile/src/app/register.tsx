import { Alert, Image, StatusBar, View } from 'react-native'
import { FontAwesome6, MaterialIcons } from '@expo/vector-icons'
import { Link, router } from 'expo-router'
import { Input } from '@/components/input'
import { colors } from '@/styles/colors'
import { Button } from '@/components/button'
import { useState } from 'react'
import { api } from '@/server/api'
import axios from 'axios'
import { useBadgeStore } from '@/store/badge-store'

export default function Register() {
  const [name, setName] = useState('Jackson')
  const [email, setEmail] = useState('jackson.f205@gmail.com')
  const [isLoading, setIsLoading] = useState(false)
  const badgeStore = useBadgeStore()

  async function handleRegister() {
    if (!name.trim()) return Alert.alert('Inscrição', 'Preencha seu nome')
    if (!email.trim()) return Alert.alert('Inscrição', 'Preencha seu email')
    setIsLoading(true)
    try {
      const eventId = '9e9bd979-9d10-4915-b339-3786b1634f33'
      const registerResponse = await api.post(`/events/${eventId}/attendees`, { name, email })
      console.log(registerResponse.data)
      if (registerResponse.data.attendeeId) {
        const badgeResponse = await api.get(`/attendees/${registerResponse.data.attendeeId}/badge`)
        badgeStore.save(badgeResponse.data.badge)
        Alert.alert('Inscrição', 'Inscrição realizada com sucesso!', [
          { text: 'OK', onPress: () => router.push('/ticket') }
        ])
      }
    } catch (error) {
      console.log(error)
      setIsLoading(false)
      if (axios.isAxiosError(error)) {
        const emailAlreadyRegistered = String(error.response?.data.message).includes('already registered')
        if (emailAlreadyRegistered) return Alert.alert('Inscrição', 'Este e-mail já está cadastrado!')
      }
      Alert.alert('Inscrição', 'Não foi possível fazer a inscrição')
    }
  }

  return (
    <View className='flex-1 bg-green-500 items-center justify-center p-8'>
      <StatusBar barStyle='light-content' />
      <Image source={require('@/assets/logo.png')} className='h-16' resizeMode='contain' />
      <View className='w-full mt-12 gap-3'>
        <Input>
          <FontAwesome6
            name='user-circle'
            color={colors.white}
            size={20}
          />
          <Input.Field placeholder='Nome completo' onChangeText={setName} />
        </Input>
        <Input>
          <MaterialIcons
            name='alternate-email'
            color={colors.white}
            size={20}
          />
          <Input.Field placeholder='E-mail' keyboardType='email-address' onChangeText={setEmail} />
        </Input>
        <Button title='Realizar inscrição' onPress={handleRegister} isLoading={isLoading} />
        <Link href='/' className='text-gray-100 text-base font-bold text-center mt-8'>
          Já possui ingresso?
        </Link>
      </View>
    </View>
  )
}
