<?php

namespace Webkul\Admin\Http\Controllers\Settings;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Event;
use Webkul\Admin\DataGrids\Settings\DescriptionTemplateDataGrid;
use Webkul\Admin\Http\Controllers\Controller;
use Webkul\Admin\Http\Resources\DescriptionTemplateResource;
use Webkul\DescriptionTemplate\Repositories\DescriptionTemplateRepository;

class DescriptionTemplateController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(
        protected DescriptionTemplateRepository $descriptionTemplateRepository
    ) {}

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\View\View
     */
    public function index()
    {
        if (request()->ajax()) {
            return datagrid(DescriptionTemplateDataGrid::class)->process();
        }

        return view('admin::settings.description-templates.index');
    }

    /**
     * Return all the templates, used to feed the TinyMCE template picker.
     */
    public function all(): JsonResponse
    {
        return new JsonResponse(
            $this->descriptionTemplateRepository->all(['id', 'name', 'content'])
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(): JsonResponse
    {
        $this->validate(request(), [
            'name'    => 'required|string',
            'content' => 'required|string',
        ]);

        Event::dispatch('description_template.create.before');

        $descriptionTemplate = $this->descriptionTemplateRepository->create(request()->only([
            'name',
            'content',
        ]));

        Event::dispatch('description_template.create.after', $descriptionTemplate);

        return new JsonResponse([
            'message' => trans('admin::app.settings.description-templates.index.create-success'),
        ]);
    }

    /**
     * Description template details.
     */
    public function edit(int $id): DescriptionTemplateResource
    {
        $descriptionTemplate = $this->descriptionTemplateRepository->findOrFail($id);

        return new DescriptionTemplateResource($descriptionTemplate);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(): JsonResponse
    {
        $id = request()->id;

        $this->validate(request(), [
            'name'    => 'required|string',
            'content' => 'required|string',
        ]);

        Event::dispatch('description_template.update.before', $id);

        $descriptionTemplate = $this->descriptionTemplateRepository->update(request()->only([
            'name',
            'content',
        ]), $id);

        Event::dispatch('description_template.update.after', $descriptionTemplate);

        return new JsonResponse([
            'message' => trans('admin::app.settings.description-templates.index.update-success'),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        try {
            Event::dispatch('description_template.delete.before', $id);

            $this->descriptionTemplateRepository->delete($id);

            Event::dispatch('description_template.delete.after', $id);

            return new JsonResponse([
                'message' => trans('admin::app.settings.description-templates.index.delete-success'),
            ]);
        } catch (\Exception $e) {
        }

        return new JsonResponse([
            'message' => trans('admin::app.settings.description-templates.index.delete-failed'),
        ], 500);
    }
}
