<?php

namespace App\Http\Controllers;

use App\Http\Requests\GetMessageRequest;
use App\Http\Requests\StoreMessageRequest;
use Illuminate\Http\Request;
use App\Models\ChatMessage;
use Illuminate\Http\JsonResponse;

class ChatMessageController extends Controller
{
    /**
     * Get chat message
     * @param \App\Http\Requests\GetMessageRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(GetMessageRequest $request): JsonResponse {
        $data = $request->validated();
        $chatId = $data["chat_id"];
        $currentPage = $data["page"];
        $pageSize = $data["page_size"] ?? 15;
        
        $messages = ChatMessage::where("chat_id", $chatId)
            ->with("user")
            ->latest('created_at')
            ->simplePaginate(
                $pageSize,
                ['*'],
                'page',
                $currentPage
            );

        return $this->success($messages->getCollection());
    }

    /**
     * Create a chat message
     * @param \App\Http\Requests\StoreMessageRequest $request
     * @return JsonResponse
     */
    public function store(StoreMessageRequest $request) {
        $data = $request->validated();
        $data['user_id'] = auth()->user()->id;
        $chatMessage = ChatMessage::create($data);
        $chatMessage->load('user');

        return $this->success($chatMessage, 'Message has been send successfully!');
    }
}
