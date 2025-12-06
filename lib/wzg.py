from docx import Document
from docx.shared import Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH

def create_plan_docx():
    doc = Document()
    
    # 标题
    title = doc.add_heading('【工作计划】思巢本地化项目 - 下月开发计划', 0)
    title.alignment = WD_ALIGN_PARAGRAPH.CENTER
    
    # 基本信息
    doc.add_paragraph('汇报人：[您的姓名]')
    doc.add_paragraph('汇报日期：202X年X月X日')
    doc.add_paragraph('项目周期：下月（第一周 至 第四周）')
    doc.add_paragraph('_' * 30) # 分割线

    # 一、工作目标
    doc.add_heading('一、 工作目标概述', level=1)
    p = doc.add_paragraph('本月核心目标为完成“思巢本地化项目”的闭环开发与联调。重点包含“成长之光Android端（新开发）”与“PC端服务器（改造）”两个部分。')
    doc.add_paragraph('主要达成目标：', style='List Bullet')
    doc.add_paragraph('数据本地化：实现课程信息与图标在本地的高效存储与读取。', style='List Bullet')
    doc.add_paragraph('双端互通：搭建稳定的局域网通信架构，实现PC与Android端的指令交互。', style='List Bullet')
    doc.add_paragraph('高可用性：确保系统具备断网重连与心跳检测机制，保证现场使用的稳定性。', style='List Bullet')

    # 二、核心任务
    doc.add_heading('二、 核心任务分解', level=1)
    
    doc.add_heading('1. 成长之光 Android版（新开发）', level=2)
    doc.add_paragraph('数据管理：', style='List Bullet')
    p = doc.add_paragraph('   - 课程信息本地化：解析并存储课程数据，实现课程图标（Image）的本地文件化存储与读取。\n   - 列表展示：开发课程列表界面，实现按分类显示所有课程，优化列表滑动流畅度。')
    
    doc.add_paragraph('网络通信（核心）：', style='List Bullet')
    p = doc.add_paragraph('   - 通信架构：搭建Socket/TCP客户端，与PC服务器进行双向通信。\n   - 稳定性保障（重点）：开发心跳检测（Heartbeat）与断网重连机制，确保连接不丢失。\n   - 交互反馈：接收服务器指令，并在UI上实时显示“课程开启成功/失败”的状态提示。')

    doc.add_heading('2. PC端服务器（改造）', level=2)
    doc.add_paragraph('功能精简：', style='List Bullet')
    doc.add_paragraph('   - 移除冗余：彻底删除原有的“课程更新功能”模块，确保代码纯净。')
    doc.add_paragraph('核心逻辑：', style='List Bullet')
    doc.add_paragraph('   - 数据读取：编写服务端逻辑，扫描并读取本地存储的所有课程文件。\n   - 指令交互：适配新协议，接收Android端指令，并反馈执行结果。')

    # 三、进度安排（表格）
    doc.add_heading('三、 详细实施进度（周计划）', level=1)
    table = doc.add_table(rows=1, cols=4)
    table.style = 'Table Grid'
    hdr_cells = table.rows[0].cells
    hdr_cells[0].text = '时间节点'
    hdr_cells[1].text = '阶段主题'
    hdr_cells[2].text = '关键任务内容'
    hdr_cells[3].text = '交付成果'

    data = [
        ['第一周', '架构搭建与PC改造', '【Android】搭建架构，实现本地数据存取。\n【PC端】删除更新功能，实现文件读取。', 'Android数据读取Demo\nPC端净化版'],
        ['第二周', 'UI开发与协议制定', '【Android】开发分类列表页，优化图片加载。\n【协同】制定通信协议。', 'UI界面完成\n通信协议文档'],
        ['第三周', '网络通信攻坚', '【Android】Socket开发，重点实现心跳与重连。\n【PC端】Socket监听与指令解析。', '双端通信打通\n重连机制测试包'],
        ['第四周', '联调测试与验收', '【联调】全流程闭环测试。\n【测试】异常网络测试（拔网线）。', '项目验收交付']
    ]

    for time, theme, task, deliver in data:
        row_cells = table.add_row().cells
        row_cells[0].text = time
        row_cells[1].text = theme
        row_cells[2].text = task
        row_cells[3].text = deliver

    # 四、风险
    doc.add_heading('四、 关键技术点与风险预案', level=1)
    doc.add_paragraph('1. 网络环境不稳定性（高风险）：', style='List Number')
    doc.add_paragraph('   风险：现场局域网波动可能导致Socket连接断开。\n   预案：增加应用层自动重连策略，UI给予明确提示。')
    doc.add_paragraph('2. 图片资源加载：', style='List Number')
    doc.add_paragraph('   风险：课程图标较多可能导致卡顿。\n   预案：采用Glide等框架开启二级缓存。')

    # 保存
    doc.save('思巢本地化项目_月度工作计划.docx')
    print("文件已生成：思巢本地化项目_月度工作计划.docx")

if __name__ == '__main__':
    try:
        create_plan_docx()
    except ImportError:
        print("请先安装 python-docx 库: pip install python-docx")