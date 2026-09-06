import 'package:flutter/material.dart';

import '../../domain/entity/catatan.dart';
import '../theme/tokens.dart';

class KartuCatatan extends StatelessWidget {
  final Catatan catatan;
  final VoidCallback onKetuk;
  final VoidCallback onHapus;

  const KartuCatatan({
    super.key,
    required this.catatan,
    required this.onKetuk,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: InkWell(
        onTap: onKetuk,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catatan.judul,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      catatan.isi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      formatTanggal(catatan.dibuatPada),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onHapus,
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Hapus catatan',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
