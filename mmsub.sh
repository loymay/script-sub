#!/bin/bash

# ==========================================
# 脚本名称: MMSUB 脚本合集管理器
# 适用平台: Linux (Ubuntu/Debian/CentOS/Alpine)
# 快捷命令: mmsub
# ==========================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 图标定义 (根据环境可能显示不同)
INFO="${BLUE}[INFO]${NC}"
SUCCESS="${GREEN}[SUCCESS]${NC}"
ERROR="${RED}[ERROR]${NC}"
WAIT="${YELLOW}[WAIT]${NC}"

# 脚本物理路径
SCRIPT_PATH="/usr/local/bin/mmsub.sh"
SHORTCUT_PATH="/usr/local/bin/mmsub"

# 检查权限
[[ $EUID -ne 0 ]] && echo -e "${ERROR} 请以 root 权限运行此脚本" && exit 1

# 安装快捷指令
install_shortcut() {
    cp "$0" "$SCRIPT_PATH" >/dev/null 2>&1
    chmod +x "$SCRIPT_PATH"
    cat > "$SHORTCUT_PATH" <<EOF
#!/bin/bash
bash $SCRIPT_PATH "\$@"
EOF
    chmod +x "$SHORTCUT_PATH"
}

# 卸载功能
uninstall_script() {
    echo -e "${WAIT} 正在卸载 MMSUB 脚本合集管理器..."
    rm -f "$SCRIPT_PATH"
    rm -f "$SHORTCUT_PATH"
    echo -e "${SUCCESS} 卸载完成！已移除快捷指令 mmsub。"
    exit 0
}

# 头部界面
draw_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}             ${PURPLE}MMSUB 脚本合集管理器 v1.0${NC}               ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# 主菜单
main_menu() {
    draw_header
    echo -e " ${BLUE}【项目分类】${NC}"
    echo -e "  [1] 多功能聚合      [2] 代理脚本"
    echo -e "  [3] 常用工具        [4] 自用脚本"
    echo ""
    echo -e " ────────────────────────────────────────────────────────────"
    echo -e "  [88] ${RED}卸载脚本${NC}       [0] ${YELLOW}退出脚本${NC}"
    echo ""
    read -p " 请输入选项 [0-88]: " main_opt

    case "$main_opt" in
        1) menu_multi ;;
        2) menu_proxy ;;
        3) menu_tools ;;
        4) menu_personal ;;
        88) uninstall_script ;;
        0) exit 0 ;;
        *) echo -e "${ERROR} 无效选项"; sleep 1; main_menu ;;
    esac
}

# --- 子菜单: 多功能聚合 ---
menu_multi() {
    draw_header
    echo -e " ${BLUE}【多功能聚合】${NC}"
    echo -e "  [1] 科技lion           [2] 老王SSH工具箱"
    echo ""
    echo -e "  [0] 返回主菜单"
    echo ""
    read -p " 请选择脚本: " sub_opt
    case "$sub_opt" in
        1) bash <(curl -sL kejilion.sh) ;;
        2) curl -fsSL https://raw.githubusercontent.com/eooce/ssh_tool/main/ssh_tool.sh -o ssh_tool.sh && chmod +x ssh_tool.sh && ./ssh_tool.sh ;;
        0) main_menu ;;
        *) echo -e "${ERROR} 无效选项"; sleep 1; menu_multi ;;
    esac
}

# --- 子菜单: 代理脚本 ---
menu_proxy() {
    draw_header
    echo -e " ${BLUE}【代理脚本】${NC}"
    echo -e "  [1] 戏子singbo-lite    [2] 戏子mtp"
    echo -e "  [3] 梭哈脚本 (Suoha)   [4] ArgoX (fscarmen)"
    echo -e "  [5] Sing-box (fscarmen [6] Sing-box (eooce)"
    echo ""
    echo -e "  [0] 返回主菜单"
    echo ""
    read -p " 请选择脚本: " sub_opt
    case "$sub_opt" in
        1) (curl -LfsS https://raw.githubusercontent.com/0xdabiaoge/singbox-lite/main/singbox.sh -o /usr/local/bin/sb || wget -q https://raw.githubusercontent.com/0xdabiaoge/singbox-lite/main/singbox.sh -O /usr/local/bin/sb) && chmod +x /usr/local/bin/sb && sb ;;
        2) (curl -LfsS https://raw.githubusercontent.com/0xdabiaoge/MTProxy/main/mtp.sh -o /usr/local/bin/mtp || wget -q https://raw.githubusercontent.com/0xdabiaoge/MTProxy/main/mtp.sh -O /usr/local/bin/mtp) && chmod +x /usr/local/bin/mtp && mtp ;;
        3) curl https://suoha.psai.eu.org/suoha.sh -o suoha.sh && chmod +x suoha.sh && bash suoha.sh ;;
        4) bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) ;;
        5) bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) ;;
        6) bash <(curl -Ls https://raw.githubusercontent.com/eooce/sing-box/main/sing-box.sh) ;;
        0) main_menu ;;
        *) echo -e "${ERROR} 无效选项"; sleep 1; menu_proxy ;;
    esac
}

# --- 子菜单: 常用工具 ---
menu_tools() {
    draw_header
    echo -e " ${BLUE}【常用工具】${NC}"
    echo -e "  [1] IP质量查询         [2] Warp脚本 (fscarmen)"
    echo -e "  [3] Warp脚本 (Misaka)  "
    echo ""
    echo -e "  [0] 返回主菜单"
    echo ""
    read -p " 请选择脚本: " sub_opt
    case "$sub_opt" in
        1) bash <(curl -Ls https://Check.Place) -I ;;
        2) wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh && bash menu.sh ;;
        3) wget -N https://gitlab.com/Misaka-blog/warp-script/-/raw/main/warp.sh && bash warp.sh ;;
        0) main_menu ;;
        *) echo -e "${ERROR} 无效选项"; sleep 1; menu_tools ;;
    esac
}

# --- 子菜单: 自用脚本 ---
menu_personal() {
    draw_header
    echo -e " ${BLUE}【自用脚本】${NC}"
    echo -e "  [1] SSB Singbox 管理"
    echo ""
    echo -e "  [0] 返回主菜单"
    echo ""
    read -p " 请选择脚本: " sub_opt
    case "$sub_opt" in
        1) wget -O singbox.sh https://raw.githubusercontent.com/loymay/ssb/main/singbox.sh && chmod +x singbox.sh && bash singbox.sh ;;
        0) main_menu ;;
        *) echo -e "${ERROR} 无效选项"; sleep 1; menu_personal ;;
    esac
}

# 执行入口
if [[ "$1" == "install" ]]; then
    install_shortcut
    echo -e "${SUCCESS} 快捷指令 mmsub 已安装。以后直接输入 mmsub 即可运行本脚本。"
else
    # 自动尝试安装快捷方式（如果不存在的话）
    [[ ! -f "$SHORTCUT_PATH" ]] && install_shortcut >/dev/null 2>&1
    main_menu
fi
