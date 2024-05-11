const prisma = require('../libs/prisma')
const getDataUserCookie = require('../utils/cookie')

class CartService {
  static async getAll() {
    try {
      const carts = await prisma.cart.findMany({
        include: {
          cartItem: true,
        },
      })
      return { carts }
    } catch (error) {
      console.log(error)
      throw error
    }
  }

  static async store(params) {
    try {
      const { cookie, body } = params
      const { product_id, quantity } = body
      const user = getDataUserCookie(cookie)
      const { id } = user
      const cart = await prisma.cart.findUnique({
        where: {
          user_id: id,
        },
      })
      const createItems = await prisma.cartItem.create({
        data: {
          cart_id: cart.id,
          product_id,
          quantity,
        },
        include: {
          cart: true,
        },
      })
      console.log(createItems)
      return { createItems }
    } catch (error) {
      console.log(error)
      throw error
    }
  }

  static async destroy(params) {
    try {
      const { cookie, item_id } = params
      const user = getDataUserCookie(cookie)
      const { id } = user
      const cart = await prisma.cart.findUnique({
        where: {
          user_id: id,
        },
      })
      const deleteItems = await prisma.cartItem.delete({
        where: {
          id: +item_id,
          cart_id: cart.id
        },
      })

      return { deleteItems }
    } catch (error) {
      console.log(error)
      throw error
    }
  }
}

module.exports = CartService
