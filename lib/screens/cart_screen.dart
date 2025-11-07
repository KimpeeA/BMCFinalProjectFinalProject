import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/payment_screen.dart'; // 1. Import PaymentScreen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 2. It's a StatelessWidget again!
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. We listen: true, so the list and total update
    final cart = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          // 4. The ListView is the same as before
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Your cart is empty.'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.secondary,
                          child: Text(cartItem.name[0], style: TextStyle(color: theme.colorScheme.onSecondary)),
                        ),
                        title: Text(cartItem.name, style: theme.textTheme.titleMedium),
                        subtitle: Text('Qty: ${cartItem.quantity}', style: theme.textTheme.bodySmall),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                '₱${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}', style: theme.textTheme.bodyLarge),
                            IconButton(
                              icon: Icon(Icons.delete, color: theme.colorScheme.error),
                              onPressed: () {
                                cart.removeItem(cartItem.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // 5. --- THIS IS OUR NEW PRICE BREAKDOWN CARD (from Module 15) ---
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal:', style: theme.textTheme.bodyLarge),
                      Text('₱${cart.subtotal.toStringAsFixed(2)}', style: theme.textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('VAT (12%):', style: theme.textTheme.bodyLarge),
                      Text('₱${cart.vat.toStringAsFixed(2)}', style: theme.textTheme.bodyLarge),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '₱${cart.totalPriceWithVat.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 6. --- THIS IS THE MODIFIED BUTTON ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              // 7. Disable if cart is empty, otherwise navigate
              onPressed: cart.items.isEmpty ? null : () {
                // 8. Navigate to our new PaymentScreen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      // 9. Pass the final VAT-inclusive total
                      totalAmount: cart.totalPriceWithVat,
                    ),
                  ),
                );
              },
              // 10. No more spinner!
              child: const Text('Proceed to Payment'),
            ),
          ),
        ],
      ),
    );
  }
}
