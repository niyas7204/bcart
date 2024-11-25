import express from 'express';
import mongoose from 'mongoose';
import productModel from '../models/product_model.js';

export const addProduct = async (req, res) => {
    try {
        const { product_name, price, description, images, quantity } = req.body;
        seller_id = req.user;
        let product = productModel({
            product_name,
            price,
            description,
            images,
            quantity,
            seller_id,
        });
        product = await product.save();
        res.status(200).json({ message: "Success", product: product });

    } catch (error) {
        res.status(500).json({ message: "Failure", error: error.message });
    }
}