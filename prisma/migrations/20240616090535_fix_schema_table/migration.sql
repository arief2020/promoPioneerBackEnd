-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "STATUS" AS ENUM ('UNCOMPLETED', 'PENDING', 'WAITING', 'SUCCESS', 'FAILED');

-- CreateTable
CREATE TABLE "City" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "rajaongkir_city_id" INTEGER NOT NULL,
    "rajaongkir_province_id" INTEGER NOT NULL,
    "province_name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "postal_code" INTEGER NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Province" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Province_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Promo" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "discount_percent" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "isLimitedQuantity" BOOLEAN NOT NULL,
    "isLimitedTime" BOOLEAN NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "promo_type_id" INTEGER NOT NULL,

    CONSTRAINT "Promo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WareHouse" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "city_id" INTEGER NOT NULL,

    CONSTRAINT "WareHouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "phone_number" TEXT,
    "city_id" INTEGER,
    "full_address" TEXT,
    "age" INTEGER,
    "gender" "Gender",
    "avatar" TEXT,
    "is_register_using_code" BOOLEAN NOT NULL,
    "is_first_transaction" BOOLEAN NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cart" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromoType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "PromoType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromoProduct" (
    "id" SERIAL NOT NULL,
    "promo_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,

    CONSTRAINT "PromoProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AffiliateCode" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "affiliate_code" TEXT NOT NULL,

    CONSTRAINT "AffiliateCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "category_id" INTEGER NOT NULL,
    "warehouse_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "product_image" TEXT NOT NULL,
    "stock" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CartItem" (
    "id" SERIAL NOT NULL,
    "cart_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CheckoutCollection" (
    "id" SERIAL NOT NULL,
    "total_item_price" INTEGER,
    "total_shipping_price" INTEGER,
    "total_price" INTEGER,
    "user_id" INTEGER NOT NULL,
    "status" "STATUS" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CheckoutCollection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Checkout" (
    "id" SERIAL NOT NULL,
    "checkout_collection_id" INTEGER NOT NULL,
    "total_checkout_price" INTEGER,
    "subtotal_price" INTEGER,
    "total_weight" INTEGER,
    "city_id" INTEGER NOT NULL,

    CONSTRAINT "Checkout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shippingCheckout" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "service" TEXT,
    "price" INTEGER,
    "checkout_id" INTEGER NOT NULL,

    CONSTRAINT "shippingCheckout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CheckoutItem" (
    "id" SERIAL NOT NULL,
    "checkout_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_specific_price" INTEGER NOT NULL,
    "original_price" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,

    CONSTRAINT "CheckoutItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CheckoutDiscount" (
    "id" SERIAL NOT NULL,
    "checkout_colection_id" INTEGER NOT NULL,
    "promo_id" INTEGER NOT NULL,
    "discount_percent" INTEGER NOT NULL,
    "total_quantity" INTEGER NOT NULL,
    "discount_price" INTEGER NOT NULL,

    CONSTRAINT "CheckoutDiscount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" SERIAL NOT NULL,
    "checkout_collection_id" INTEGER NOT NULL,
    "payment_proof" TEXT,
    "payment_status" "STATUS" NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Promo_name_key" ON "Promo"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Cart_user_id_key" ON "Cart"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "PromoProduct_promo_id_product_id_key" ON "PromoProduct"("promo_id", "product_id");

-- CreateIndex
CREATE UNIQUE INDEX "AffiliateCode_user_id_key" ON "AffiliateCode"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "AffiliateCode_affiliate_code_key" ON "AffiliateCode"("affiliate_code");

-- CreateIndex
CREATE UNIQUE INDEX "Product_warehouse_id_key" ON "Product"("warehouse_id");

-- CreateIndex
CREATE UNIQUE INDEX "shippingCheckout_checkout_id_key" ON "shippingCheckout"("checkout_id");

-- CreateIndex
CREATE UNIQUE INDEX "CheckoutDiscount_checkout_colection_id_promo_id_key" ON "CheckoutDiscount"("checkout_colection_id", "promo_id");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_checkout_collection_id_key" ON "Payment"("checkout_collection_id");

-- AddForeignKey
ALTER TABLE "Promo" ADD CONSTRAINT "Promo_promo_type_id_fkey" FOREIGN KEY ("promo_type_id") REFERENCES "PromoType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WareHouse" ADD CONSTRAINT "WareHouse_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "City"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cart" ADD CONSTRAINT "Cart_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromoProduct" ADD CONSTRAINT "PromoProduct_promo_id_fkey" FOREIGN KEY ("promo_id") REFERENCES "Promo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromoProduct" ADD CONSTRAINT "PromoProduct_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AffiliateCode" ADD CONSTRAINT "AffiliateCode_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "WareHouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_cart_id_fkey" FOREIGN KEY ("cart_id") REFERENCES "Cart"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CheckoutCollection" ADD CONSTRAINT "CheckoutCollection_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Checkout" ADD CONSTRAINT "Checkout_city_id_fkey" FOREIGN KEY ("city_id") REFERENCES "City"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Checkout" ADD CONSTRAINT "Checkout_checkout_collection_id_fkey" FOREIGN KEY ("checkout_collection_id") REFERENCES "CheckoutCollection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shippingCheckout" ADD CONSTRAINT "shippingCheckout_checkout_id_fkey" FOREIGN KEY ("checkout_id") REFERENCES "Checkout"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CheckoutItem" ADD CONSTRAINT "CheckoutItem_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CheckoutItem" ADD CONSTRAINT "CheckoutItem_checkout_id_fkey" FOREIGN KEY ("checkout_id") REFERENCES "Checkout"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CheckoutDiscount" ADD CONSTRAINT "CheckoutDiscount_checkout_colection_id_fkey" FOREIGN KEY ("checkout_colection_id") REFERENCES "CheckoutCollection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CheckoutDiscount" ADD CONSTRAINT "CheckoutDiscount_promo_id_fkey" FOREIGN KEY ("promo_id") REFERENCES "Promo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_checkout_collection_id_fkey" FOREIGN KEY ("checkout_collection_id") REFERENCES "CheckoutCollection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
