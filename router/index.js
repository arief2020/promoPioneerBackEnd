const express = require('express')
const router = express.Router()

const authRoute = require('./auth/index')
const categoryRoute = require('./category/index')
// const authRouter = require("./auth/authRouter");

router.get('/api/hello', function (req, res) {
  res.status(200).json({ message: 'hello world' })
})
router.use('/api/category', categoryRoute)
router.use('/api/auth', authRoute)
router.use('/api/rajaongkircity', categoryRoute)

module.exports = router
