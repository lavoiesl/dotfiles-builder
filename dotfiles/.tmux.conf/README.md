# .tmux.conf

1. All files in [`parts`](parts) will be included in order.
   If the file ends with `.sh`, it will be executed and its output will be used.
2. All files in [`status-left`](status-left) will be concatenated to form `status-left` option.
   If the file ends with `.sh`, it will be executed and its output will be used.
3. Same for [`status-right`](status-right).
